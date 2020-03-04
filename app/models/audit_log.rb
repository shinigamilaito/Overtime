class AuditLog < ApplicationRecord
  belongs_to :user

  validates :status, :start_date, presence: true

  after_initialize :set_defaults

  private

  def set_defaults
    self.start_date ||=  Date.today - 6.days
  end
end
