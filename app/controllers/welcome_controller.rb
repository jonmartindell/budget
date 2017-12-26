class WelcomeController < ApplicationController
  def index
    @month = "January"
    @categories = Category.all
    @uncommon_categories = Category.all
  end
end
