require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'relationships' do
    it { should have_many :employee_tickets }
    it { should have_many(:employees).through :employee_tickets }
  end

  describe 'instance methods' do
    it 'has fellow ticket holders' do
      dep = Department.create!(name: "Backend", floor: 1)
      jack = Employee.create!(name: "Jack", level: 2, department_id: dep.id)
      john = Employee.create!(name: "John", level: 1, department_id: dep.id)
      jeff = Employee.create!(name: "Jeff", level: 3, department_id: dep.id)

      phone = Ticket.create!(subject: "phone", age: 7)

      pager = Ticket.create!(subject: "pager", age: 9)

      EmployeeTicket.create!(employee_id: jack.id, ticket_id: phone.id)
      EmployeeTicket.create!(employee_id: john.id, ticket_id: phone.id)

      EmployeeTicket.create!(employee_id: john.id, ticket_id: pager.id)
      EmployeeTicket.create!(employee_id: jeff.id, ticket_id: pager.id)

      expect(phone.fellow_ticket_holders(jack.id).first).to eq(john)
      expect(phone.fellow_ticket_holders(john.id).first).to eq(jack)
      expect(pager.fellow_ticket_holders(john.id).first).to eq(jeff)
      expect(pager.fellow_ticket_holders(jeff.id).first).to eq(john)
    end
  end
end