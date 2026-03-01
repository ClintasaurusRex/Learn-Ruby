# frozen_string_literal: true

require 'tmpdir'
require_relative '../src/task_manager'

RSpec.describe TaskManager do
  it 'persists added tasks to JSON' do
    Dir.mktmpdir do |dir|
      store = JsonStore.new(File.join(dir, 'tasks.json'))
      manager = described_class.new(store: store)

      manager.add_task(title: 'Pay rent', due_date: '2026-03-05')

      reloaded = described_class.new(store: store)
      expect(reloaded.list.map(&:title)).to include('Pay rent')
    end
  end

  it 'supports recurring tasks and next due date calculation' do
    task = RecurringTask.new(title: 'Review', due_date: '2026-03-01', interval_days: 7)
    expect(task.next_due_date.to_s).to eq('2026-03-08')
  end
end
