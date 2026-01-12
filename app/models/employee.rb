class Employee < ApplicationRecord
  validates :full_name, :job_title, :country, :salary, presence: true
  validates :salary, numericality: { greater_than: 0 }
end
