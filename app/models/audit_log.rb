class AuditLog < ApplicationRecord
  enum status: { pending: 0, confirmed: 1 }

  belongs_to :user

  validates :status, :start_date, presence: true

  after_initialize :set_defaults
  before_update :set_end_date, if: :confirmed?

  private

  def set_end_date
    self.end_date = Date.today
  end

  def set_defaults
    self.start_date ||=  Date.today - 6.days
  end
end
