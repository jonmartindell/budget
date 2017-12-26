class WelcomeController < ApplicationController
  def index
    @categories = [
      OpenStruct.new(name: "Groceries", ytd: 100, remaining: 400, budget: 1000 ),
      OpenStruct.new(name: "Home Maintenance", ytd: -2500, remaining: 770, budget: 890 ),
      OpenStruct.new(name: "Restaurants", ytd: 30, remaining: -20, budget: 130 ),
      OpenStruct.new(name: "Utilities", ytd: 30, remaining: 20, budget: 290 ),
    ]

    @uncommon_categories = [
      OpenStruct.new(name: "Groceries", ytd: 100, remaining: 400, budget: 1000 ),
      OpenStruct.new(name: "Home Maintenance", ytd: -2500, remaining: 770, budget: 890 ),
      OpenStruct.new(name: "Restaurants", ytd: 30, remaining: -20, budget: 130 ),
      OpenStruct.new(name: "Utilities", ytd: 30, remaining: 20, budget: 290 ),
    ]
  end
end
