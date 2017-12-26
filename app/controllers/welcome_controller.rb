class WelcomeController < ApplicationController
  def index
    @month = "January"
    @categories = Category.where(infrequent: false)
    @uncommon_categories = Category.where(infrequent: true)
  end
end
