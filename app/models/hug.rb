class Hug < ApplicationRecord
  include ActiveModel::Validations
  
  belongs_to :user
  validates :year, numericality: {only_integer: true, equal_to: 2021}, presence: true
  validates :month, numericality: {only_integer: true, less_than_or_equal_to: 12, }, presence: true
  validates :date, numericality: {only_integer: true, less_than_or_equal_to: 31}, presence: true
  validates :count, numericality: {only_integer: true, greater_than_or_equal_to: 1}, presence: true
  validate :date_checker, on: :create
  
  
  private
  
  def date_checker
    if ((month == 4 || month == 6 || month == 9 || month ==11) && date > 30)||(month == 2 && date > 28)
      errors[:base] << "そのような日付は存在しません"
    end
  end
end
