class BankAccount < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to:0.00}
  validates :account_number, presence: true, uniqueness: true
  
  
  before_validation :load_defaults

  has_many :account_transactions
  
  def load_defaults
    if self.new_record?
      self.balance = 0.00
      self.account_number = SecureRandom.uuid
    end
  end

  def to_s
    account_number
  end
end
