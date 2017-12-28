class Transaction < ActiveRecord::Base
  default_scope { order(:date) }

  belongs_to :user
  belongs_to :category
end
