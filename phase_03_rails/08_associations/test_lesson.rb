# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 08: Associations' do
  it 'describes belongs_to' do
    expect(belongs_to_example).to eq('Book belongs_to Author')
  end

  it 'checks foreign key location' do
    expect(valid_foreign_key?(author_id: 1)).to be(true)
    expect(valid_foreign_key?(id: 1)).to be(false)
  end

  it 'maps enrollments to course titles' do
    enrollments = [{ course: { title: 'Rails 201' } }, { course: { title: 'Ruby 101' } }]
    expect(course_titles_from_enrollments(enrollments)).to eq(['Rails 201', 'Ruby 101'])
  end

  it 'returns association labels' do
    expect(association_triangle).to eq(['belongs_to', 'has_many', 'has_many :through'])
  end

  it 'formats relation summary' do
    expect(relation_summary('Octavia Butler', 2)).to eq('Author Octavia Butler has 2 books')
  end
end
