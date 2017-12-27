class WelcomeController < ApplicationController
  def index
    @month = params.fetch(:month, default_month)
    @prior_month, @next_month = months_for(@month)
    @expenses = Category.where(expense: true).to_a.group_by(&:heading)
    @incomes = Category.where(expense: false).to_a.group_by(&:heading)
  end

  private
  def default_month
    Date::MONTHNAMES[Time.now.month]
  end

  def months_for(month)
    current_index = Date::MONTHNAMES.index(month)
    if current_index == 1
      prior_month = "December"
    else
      prior_month = Date::MONTHNAMES[current_index - 1]
    end

    if current_index == 12
      next_month = "January"
    else
      next_month = Date::MONTHNAMES[current_index + 1]
    end

    [prior_month, next_month]
  end
end
