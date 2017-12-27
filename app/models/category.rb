class Category < ActiveRecord::Base

  def ytd_spent(month)
    cutoff_date = month.to_date.beginning_of_month
    # Sum of all transactions < cutoff_date
    Transactions.where(category_id: id).where("date < ?", cutoff_date).sum(:amount)
  end

  def spent(month)
    begin_date = month.to_date.beginning_of_month
    end_date = month.to_date.end_of_month
    # Sum of all transactions >=begin_date && <= end_date
    Transactions.where(category_id: id).where("date >= ? AND date <= ?", begin_date, end_date).sum(:amount)
  end

  def remaining(month)
    budget_to_eom(month) - spent(month) - ytd_spent(month)
  end

  def budget_to_som(month)
    month_num = Date::MONTHNAMES.index(month) - 1
    budget * month_num
  end

  def budget_to_eom(month)
    month_num = Date::MONTHNAMES.index(month)
    budget * month_num
  end

  def spent_to_eom(month)
    spent(month) + ytd_spent(month)
  end

  def status(month)
    if infrequent
      yearly_max = budget * 12
      return :danger if (spent_to_eom(month) >= yearly_max)

      # warning if tracking that you'll spend allll the money too soon
      percentage_yearly_spent = spent_to_eom(month) / yearly_max.to_f
      percentage_of_year = month.to_date.end_of_month.yday / 365.to_f
      case
      when percentage_yearly_spent >= .40 && percentage_of_year <= .10
        return :warning
      when percentage_yearly_spent >= .50 && percentage_of_year <= .20
        return :warning
      when percentage_yearly_spent >= .60 && percentage_of_year <= .30
        return :warning
      when percentage_yearly_spent >= .70 && percentage_of_year <= .40
        return :warning
      when percentage_yearly_spent >= .80 && percentage_of_year <= .60
        return :warning
      when percentage_yearly_spent >= .90 && percentage_of_year <= .90
        return :warning
      else
        return nil
      end
    else
      return :danger if (spent_to_eom(month) > budget_to_eom(month))
      if month == "January"
        percentage_of_ytd_spent = 0.0
      else
        percentage_of_ytd_spent = ytd_spent(month) / budget_to_som(month).to_f
      end
      percentage_of_month_spent = spent(month) / budget
      return :warning if percentage_of_ytd_spent >= .90 && percentage_of_month_spent >= .90
    end
  end
end
