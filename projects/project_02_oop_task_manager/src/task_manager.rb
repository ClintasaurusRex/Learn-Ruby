# frozen_string_literal: true

require 'json'
require 'date'
require 'securerandom'

class Entity
  attr_reader :id, :title

  def initialize(title:, id: SecureRandom.uuid)
    @id = id
    @title = title
  end
end

class Task < Entity
  attr_reader :status, :due_date

  def initialize(title:, due_date:, status: 'open', id: SecureRandom.uuid)
    super(title: title, id: id)
    @status = status
    @due_date = Date.parse(due_date.to_s)
  end

  def to_h
    { type: self.class.name, id: id, title: title, status: status, due_date: due_date.to_s }
  end
end

class RecurringTask < Task
  attr_reader :interval_days

  def initialize(title:, due_date:, interval_days:, status: 'open', id: SecureRandom.uuid)
    super(title: title, due_date: due_date, status: status, id: id)
    @interval_days = interval_days.to_i
  end

  def next_due_date
    due_date + interval_days
  end

  def to_h
    super.merge(interval_days: interval_days)
  end
end

class TaskCollection
  attr_reader :tasks

  def initialize(tasks = [])
    @tasks = tasks
  end

  def add(task)
    tasks << task
  end

  def all
    tasks
  end
end

class JsonStore
  def initialize(path)
    @path = path
  end

  def load
    return [] unless File.exist?(@path)

    JSON.parse(File.read(@path)).map do |row|
      if row['type'] == 'RecurringTask'
        RecurringTask.new(title: row['title'], due_date: row['due_date'], interval_days: row['interval_days'], status: row['status'], id: row['id'])
      else
        Task.new(title: row['title'], due_date: row['due_date'], status: row['status'], id: row['id'])
      end
    end
  end

  def save(tasks)
    File.write(@path, JSON.pretty_generate(tasks.map(&:to_h)))
  end
end

class TaskManager
  def initialize(store:, collection: TaskCollection.new)
    @store = store
    @collection = collection
    store.load.each { |task| @collection.add(task) }
  end

  def add_task(title:, due_date:)
    task = Task.new(title: title, due_date: due_date)
    @collection.add(task)
    persist
    task
  end

  def add_recurring_task(title:, due_date:, interval_days:)
    task = RecurringTask.new(title: title, due_date: due_date, interval_days: interval_days)
    @collection.add(task)
    persist
    task
  end

  def list
    @collection.all
  end

  private

  def persist
    @store.save(@collection.all)
  end
end

class CLI
  def self.run(argv = ARGV)
    store = JsonStore.new(File.expand_path('../tasks.json', __dir__))
    manager = TaskManager.new(store: store)
    command = argv.shift

    case command
    when 'add'
      title = argv.shift
      due = argv[argv.index('--due') + 1]
      manager.add_task(title: title, due_date: due)
      puts "Added task: #{title}"
    when 'add-recurring'
      title = argv.shift
      due = argv[argv.index('--due') + 1]
      interval = argv[argv.index('--interval') + 1]
      manager.add_recurring_task(title: title, due_date: due, interval_days: interval)
      puts "Added recurring task: #{title}"
    when 'list'
      manager.list.each do |task|
        puts "[#{task.status}] #{task.title} (due #{task.due_date})"
      end
    else
      puts 'Usage: add TITLE --due YYYY-MM-DD | add-recurring TITLE --due YYYY-MM-DD --interval DAYS | list'
      return 1
    end

    0
  end
end

exit(CLI.run) if $PROGRAM_NAME == __FILE__
