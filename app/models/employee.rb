class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def oldest_ticket
    tickets.order(age: :desc).limit(1).first.subject
  end

  def shared_tickets
    tickets.joins(:employees).group(:id).having('count(employees) > 1')
  end
end