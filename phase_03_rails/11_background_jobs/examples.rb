# frozen_string_literal: true

class SimpleQueue
  def initialize
    @jobs = []
  end

  def enqueue(job)
    @jobs << job
  end

  def dequeue
    @jobs.shift
  end

  def empty?
    @jobs.empty?
  end
end

class Worker
  def initialize(queue)
    @queue = queue
  end

  def process_all
    until @queue.empty?
      job = @queue.dequeue
      puts "Processed: #{job}"
    end
  end
end

queue = SimpleQueue.new
queue.enqueue('SendWelcomeEmail')
queue.enqueue('GenerateWeeklyReport')

Worker.new(queue).process_all
