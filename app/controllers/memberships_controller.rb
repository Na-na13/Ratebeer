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
    @user = current_user
    @member = Membership.find_by user_id: @user.id
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
    @membership = Membership.new(membership_params)
    @beer_clubs = BeerClub.all
    # @user = current_user
    @membership.user_id = @user.id
    @beer_club = BeerClub.find_by id: @membership.beer_club_id

    if @beer_club.members.include? current_user
      redirect_to new_membership_path, notice: "You are already member of #{@beer_club}"
      return
    end

    respond_to do |format|
      if @membership.save
        format.html { redirect_to beer_club_url(@beer_club), notice: "You are now member of #{@beer_club}." }
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
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url, notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end
