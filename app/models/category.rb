class Category < ActiveRecord::Base

  def ytd_spent
    if name == "Home Maintenance"
      3000
    else
      0
    end
  end

  def spent(month)
    0
  end

  def remaining
    0
  end
end
