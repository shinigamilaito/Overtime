class User < ApplicationRecord
  PHONE_REGEX = /\A\d*\z/

  has_many :posts
  has_many :audit_logs
  has_many :hands_associations, class_name: 'Hand'
  has_many :hands, through: :hands_associations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone, :ssn, :company, presence: true

  validates :phone, format: { with: PHONE_REGEX }
  validates :phone, length: { is: 10 }

  validates :ssn, length:  { is: 4 }
  validates :ssn, numericality: { only_integer: true }

  def full_name
    last_name.upcase + ", " + first_name.upcase
  end
end
