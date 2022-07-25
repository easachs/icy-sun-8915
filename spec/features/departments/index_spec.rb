require 'rails_helper'

RSpec.describe 'Department Index' do
  describe 'Story 1' do
    it 'has dep index w/each deps name and floor, and list of employees' do
      dep = Department.create!(name: "Backend", floor: 1)
      jack = Employee.create!(name: "Jack", level: 2, department_id: dep.id)
      john = Employee.create!(name: "John", level: 1, department_id: dep.id)
      jeff = Employee.create!(name: "Jeff", level: 3, department_id: dep.id)
      dep_2 = Department.create!(name: "Frontend", floor: 3)
      harry = Employee.create!(name: "Harry", level: 4, department_id: dep_2.id)
      huey = Employee.create!(name: "Huey", level: 6, department_id: dep_2.id)
      howie = Employee.create!(name: "Howie", level: 5, department_id: dep_2.id)

      visit "/departments"

      within "#dep-#{dep.id}" do
        expect(page).to have_content("Backend")
        expect(page).to have_content("Floor 1")
        expect(page).to have_content("Jack")
        expect(page).to have_content("John")
        expect(page).to have_content("Jeff")
        expect(page).to_not have_content("Frontend")
        expect(page).to_not have_content("Floor 3")
        expect(page).to_not have_content("Harry")
      end

      within "#dep-#{dep_2.id}" do
        expect(page).to have_content("Frontend")
        expect(page).to have_content("Floor 3")
        expect(page).to have_content("Harry")
        expect(page).to have_content("Huey")
        expect(page).to have_content("Howie")
        expect(page).to_not have_content("Backend")
        expect(page).to_not have_content("Floor 1")
        expect(page).to_not have_content("Jack")
      end
    end
  end
end