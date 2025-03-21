require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through :employee_tickets }
  end

  describe 'instance methods' do
    it 'has oldest ticket' do
      dep = Department.create!(name: "Backend", floor: 1)
      jack = Employee.create!(name: "Jack", level: 2, department_id: dep.id)

      printer = Ticket.create!(subject: "printer", age: 1)
      copier = Ticket.create!(subject: "copier", age: 3)
      fax = Ticket.create!(subject: "fax", age: 5)

      EmployeeTicket.create!(employee_id: jack.id, ticket_id: printer.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: copier.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: fax.id)

      expect(jack.oldest_ticket).to eq("fax")
    end

    it 'has shared with' do
      dep = Department.create!(name: "Backend", floor: 1)
      jack = Employee.create!(name: "Jack", level: 2, department_id: dep.id)
      john = Employee.create!(name: "John", level: 1, department_id: dep.id)
      jeff = Employee.create!(name: "Jeff", level: 3, department_id: dep.id)

      printer = Ticket.create!(subject: "printer", age: 1)
      copier = Ticket.create!(subject: "copier", age: 3)
      fax = Ticket.create!(subject: "fax", age: 5)

      phone = Ticket.create!(subject: "phone", age: 7)

      pager = Ticket.create!(subject: "pager", age: 9)

      EmployeeTicket.create!(employee_id: jack.id, ticket_id: printer.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: copier.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: fax.id)

      EmployeeTicket.create!(employee_id: john.id, ticket_id: phone.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: phone.id)

      EmployeeTicket.create!(employee_id: john.id, ticket_id: pager.id)
      EmployeeTicket.create!(employee_id: jeff.id, ticket_id: pager.id)

      expect(jack.shared_tickets.first).to eq(phone)
    end
  end
end