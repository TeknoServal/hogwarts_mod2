require 'rails_helper'

describe 'As a user' do
  before(:each) do
    snape = Professor.create(name: 'Severus Snape', age: 45, specialty: 'Potions')
    hagarid = Professor.create(name: 'Rubeus Hagrid', age: 38, specialty: 'Care of Magical Creatures')
    lupin = Professor.create(name: 'Remus Lupin', age: 49, specialty: 'Defense Against The Dark Arts')

    harry = Student.create(name: 'Harry Potter', age: 11, house: 'Gryffindor')
    malfoy = Student.create(name: 'Draco Malfoy', age: 12, house: 'Slytherin')
    longbottom = Student.create(name: 'Neville Longbottom', age: 11, house: 'Gryffindor')

    ProfessorStudent.create(student_id: harry.id, professor_id: snape.id)
    ProfessorStudent.create(student_id: harry.id, professor_id: hagarid.id)
    ProfessorStudent.create(student_id: harry.id, professor_id: lupin.id)
    ProfessorStudent.create(student_id: malfoy.id, professor_id: hagarid.id)
    ProfessorStudent.create(student_id: malfoy.id, professor_id: lupin.id)
    ProfessorStudent.create(student_id: longbottom.id, professor_id: snape.id)
  end

  describe "When I visit '/professors/:id' " do
    it "I see a list of names of the students the professors have" do
      Professor.all.each do |professor|
        visit "/professors/#{professor.id}"

        professor.students.each do |student|
          expect(page).to have_content(student.name)
        end
      end
    end
  end
end