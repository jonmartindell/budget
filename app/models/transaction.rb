class Transaction < ActiveRecord::Base
  default_scope order(date: :desc)

  belongs_to :user
  belongs_to :category
end
