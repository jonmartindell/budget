class Category < ActiveRecord::Base

  def ytd_spent
    0
  end

  def spent(month)
    0
  end

  def remaining
    0
  end
end
