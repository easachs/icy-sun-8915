require 'rails_helper'

RSpec.describe 'Employee Show' do
  describe 'Story 2' do
    it 'has emps name, dep and list of all tickets from old to young, oldest ticket listed separately' do
      dep = Department.create!(name: "Backend", floor: 1)
      jack = Employee.create!(name: "Jack", level: 2, department_id: dep.id)
      john = Employee.create!(name: "John", level: 1, department_id: dep.id)

      printer = Ticket.create!(subject: "printer", age: 1)
      copier = Ticket.create!(subject: "copier", age: 3)
      fax = Ticket.create!(subject: "fax", age: 5)

      phone = Ticket.create!(subject: "phone", age: 7)

      EmployeeTicket.create!(employee_id: jack.id, ticket_id: printer.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: copier.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: fax.id)

      EmployeeTicket.create!(employee_id: john.id, ticket_id: phone.id)

      visit "/employees/#{jack.id}"

      within "#employee" do
        expect(page).to have_content("Jack")
        expect(page).to have_content("Backend")
        expect(page).to have_content("printer")
        expect(page).to have_content("copier")
        expect(page).to have_content("fax")
        expect(page).to_not have_content("John")
        expect(page).to_not have_content("phone")
      end

      within "#oldest-ticket" do
        expect(page).to have_content("Oldest ticket: fax")
      end
    end
  end

  describe 'Story 3' do
      it 'can add a ticket for this employee' do
      dep = Department.create!(name: "Backend", floor: 1)
      jack = Employee.create!(name: "Jack", level: 2, department_id: dep.id)
      john = Employee.create!(name: "John", level: 1, department_id: dep.id)

      printer = Ticket.create!(subject: "printer", age: 1)
      copier = Ticket.create!(subject: "copier", age: 3)
      fax = Ticket.create!(subject: "fax", age: 5)

      phone = Ticket.create!(subject: "phone", age: 7)

      pager = Ticket.create!(subject: "pager", age: 9)

      EmployeeTicket.create!(employee_id: jack.id, ticket_id: printer.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: copier.id)
      EmployeeTicket.create!(employee_id: jack.id, ticket_id: fax.id)

      visit "/employees/#{jack.id}"

      within "#employee" do
        expect(page).to have_content("Jack")
        expect(page).to have_content("Backend")
        expect(page).to have_content("printer")
        expect(page).to have_content("copier")
        expect(page).to have_content("fax")
        expect(page).to_not have_content("John")
        expect(page).to_not have_content("phone")
      end

      within "#oldest-ticket" do
        expect(page).to have_content("Oldest ticket: fax")
      end

      fill_in "Ticket number", with: "#{phone.id}"
      click_on("Add ticket")

      expect(current_path).to eq("/employees/#{jack.id}")

      within "#employee" do
        expect(page).to have_content("phone")
      end

      within "#oldest-ticket" do
        expect(page).to have_content("Oldest ticket: phone")
      end
    end
  end
end