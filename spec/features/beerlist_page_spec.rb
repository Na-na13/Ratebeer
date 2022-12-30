require 'rails_helper'

describe "Beerlist page" do
    before :all do
        Capybara.register_driver :selenium do |app|
          Capybara::Selenium::Driver.new(app, :browser => :chrome)
        end
        WebMock.allow_net_connect!
      end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(1)')
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order by name", :js => true do
    visit beerlist_path
    beers = page.all('#beertable .tablerow')
    expect(beers[0]).to have_content "Fastenbier"
    expect(beers[1]).to have_content "Lechte Weisse"
    expect(beers[2]).to have_content "Nikolai"
  end

  it "when click 'style' shows beers in alphabetical order by style", :js => true do
    visit beerlist_path
    find('#style').click
    beers = page.all('#beertable .tablerow')
    expect(beers[0]).to have_content "Nikolai"
    expect(beers[1]).to have_content "Fastenbier"
    expect(beers[2]).to have_content "Lechte Weisse"
  end

  it "when click 'brewery' shows beers in alphabetical order by style", :js => true do
    visit beerlist_path
    find('#brewery').click
    beers = page.all('#beertable .tablerow')
    expect(beers[0]).to have_content "Lechte Weisse"
    expect(beers[1]).to have_content "Nikolai"
    expect(beers[2]).to have_content "Fastenbier"
  end

end