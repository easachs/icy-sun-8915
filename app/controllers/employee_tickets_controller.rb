class EmployeeTicketsController < ApplicationController

  def create
    employee = Employee.find(params[:id])
    ticket = Ticket.find(params[:ticket_number])
    EmployeeTicket.create!(employee_id: employee.id, ticket_id: params[:ticket_number])
    redirect_to "/employees/#{employee.id}"
  end

end