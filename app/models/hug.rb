class Hug < ApplicationRecord
  belongs_to :user
  validates :year, numericality: {only_integer: true, equal_to: 2021}, presence: true
  validates :month, numericality: {only_integer: true, less_than_or_equal_to: 12}, presence: true
  validates :date, numericality: {only_integer: true, less_than_or_equal_to: 31}, presence: true
  validates :count, numericality: {only_integer: true}, presence: true
end
