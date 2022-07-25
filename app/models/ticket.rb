class Ticket < ApplicationRecord
  has_many :employee_tickets
  has_many :employees, through: :employee_tickets

  def fellow_ticket_holders(employee_id)
    employees.distinct.where.not(id: employee_id)
  end
end