class Transaction < ActiveRecord::Base
  default_scope { order(:date) }
  scope :transfers, -> { where(transfer: true) }
  scope :non_transfers, -> { where(transfer: [false, nil]) }

  belongs_to :user
  belongs_to :category
end
