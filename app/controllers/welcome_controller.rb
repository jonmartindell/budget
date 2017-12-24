class WelcomeController < ApplicationController
  def index
    @categories = [
      OpenStruct.new(name: "Groceries", ytd: 100, remaining: 400 ),
      OpenStruct.new(name: "Home Maintenance", ytd: -2500, remaining: 770 ),
      OpenStruct.new(name: "Restaurants", ytd: 30, remaining: -20 ),
    ]
  end
end
