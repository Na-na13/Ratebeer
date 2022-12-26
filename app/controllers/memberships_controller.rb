class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @member = Membership.find_by user_id: current_user.id
    @beer_clubs = if @member.nil?
                    BeerClub.all
                  else
                    BeerClub.where.not(id: @member.beer_club_id)
                  end
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @beer_club = BeerClub.find(params['membership']['beer_club_id'])
    if @beer_club.members.include? current_user
      redirect_to new_membership_path, notice: "You are already member of #{@beer_club}"
      return
    end

    @membership = Membership.new(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to beer_club_url(@beer_club), notice: "#{current_user.username}, welcome to the club #{@beer_club}." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @beer_club = BeerClub.where(id: @membership.beer_club_id)[0]
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to current_user, notice: "Membership in #{@beer_club.name} ended." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
    # @membership = Membership.find()
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id, :id)
  end
end
