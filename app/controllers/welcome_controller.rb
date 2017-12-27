class WelcomeController < ApplicationController
  def index
    @month = "January"
    @categories = Category.order(:heading, :name).all.to_a.group_by(&:heading)
  end
end
