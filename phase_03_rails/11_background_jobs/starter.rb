# frozen_string_literal: true

class SimpleQueue
  def initialize
    @jobs = []
  end

  def enqueue(job)
    # TODO: add job to queue
  end

  def dequeue
    # TODO: return next job
  end
end

queue = SimpleQueue.new
queue.enqueue('SendWelcomeEmail')
queue.enqueue('GenerateWeeklyReport')

puts queue.dequeue
puts queue.dequeue
