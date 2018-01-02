class Category < ActiveRecord::Base
  default_scope { order(:sort) }

  def ytd_spent(month)
    cutoff_date = month.to_date.beginning_of_month
    # Sum of all transactions < cutoff_date
    Transaction.where(category_id: id).where("date < ?", cutoff_date).sum(:amount).to_i
  end

  def spent(month)
    begin_date = month.to_date.beginning_of_month
    end_date = month.to_date.end_of_month
    # Sum of all transactions >=begin_date && <= end_date
    Transaction.where(category_id: id).where("date >= ? AND date <= ?", begin_date, end_date).sum(:amount).to_i
  end

  def remaining(month)
    (budget_to_eom(month) - spent(month) - ytd_spent(month)).to_i
  end

  def budget_to_som(month)
    month_num = Date::MONTHNAMES.index(month) - 1
    (budget * month_num).to_i
  end

  def budget_to_eom(month)
    month_num = Date::MONTHNAMES.index(month)
    (budget * month_num).to_i
  end

  def spent_to_eom(month)
    (spent(month) + ytd_spent(month)).to_i
  end

  def remaining_for_year(month)
    budget_for_year = budget * 12
    (budget_for_year - spent_to_eom(month)).to_i
  end

  def yearly_percent_remaining(month)
    budget_for_year = budget * 12
    (remaining_for_year(month) / budget_for_year.to_f * 100).to_i
  end

  def status(month)
    if infrequent
      yearly_max = budget * 12
      return :danger if (spent_to_eom(month) >= yearly_max)

      # warning if tracking that you'll spend allll the money too soon
      percentage_yearly_spent = spent_to_eom(month) / yearly_max.to_f
      percentage_of_year = month.to_date.end_of_month.yday / 365.to_f
      case
      when percentage_yearly_spent >= 0.40 && percentage_of_year <= 0.10
        return :warning
      when percentage_yearly_spent >= 0.50 && percentage_of_year <= 0.20
        return :warning
      when percentage_yearly_spent >= 0.60 && percentage_of_year <= 0.30
        return :warning
      when percentage_yearly_spent >= 0.70 && percentage_of_year <= 0.40
        return :warning
      when percentage_yearly_spent >= 0.80 && percentage_of_year <= 0.60
        return :warning
      when percentage_yearly_spent >= 0.90 && percentage_of_year <= 0.90
        return :warning
      else
        return :success
      end
    else
      return :danger if (spent_to_eom(month) > budget_to_eom(month))
      if month == "January"
        percentage_of_ytd_spent = 0.0
      else
        percentage_of_ytd_spent = ytd_spent(month) / budget_to_som(month).to_f
      end
      percentage_of_month_spent = spent(month) / budget
      return :warning if percentage_of_ytd_spent >= 0.90 && percentage_of_month_spent >= 0.90
      #
      # Otherwise
      return :success
    end
  end

  def status_reason(month)
    if infrequent
      yearly_max = budget * 12
      return "Exceeded budget for year" if (spent_to_eom(month) >= yearly_max)

      # warning if tracking that you'll spend allll the money too soon
      percentage_yearly_spent = spent_to_eom(month) / yearly_max.to_f
      percentage_of_year = month.to_date.end_of_month.yday / 365.to_f
      case
      when percentage_yearly_spent >= 0.40 && percentage_of_year <= 0.10
        return "Spending yearly amount too quickly in year"
      when percentage_yearly_spent >= 0.50 && percentage_of_year <= 0.20
        return "Spending yearly amount too quickly in year"
      when percentage_yearly_spent >= 0.60 && percentage_of_year <= 0.30
        return "Spending yearly amount too quickly in year"
      when percentage_yearly_spent >= 0.70 && percentage_of_year <= 0.40
        return "Spending yearly amount too quickly in year"
      when percentage_yearly_spent >= 0.80 && percentage_of_year <= 0.60
        return "Spending yearly amount too quickly in year"
      when percentage_yearly_spent >= 0.90 && percentage_of_year <= 0.90
        return "Spending yearly amount too quickly in year"
      else
        return ""
      end
    else
      return "Exceeded budget for #{month}" if (spent_to_eom(month) > budget_to_eom(month))
      if month == "January"
        percentage_of_ytd_spent = 0.0
      else
        percentage_of_ytd_spent = ytd_spent(month) / budget_to_som(month).to_f
      end
      percentage_of_month_spent = spent(month) / budget
      return "Getting too close to exceeding YTD budget" if percentage_of_ytd_spent >= 0.90 && percentage_of_month_spent >= 0.90
      #
      # Otherwise
      return ""
    end

  end
end
