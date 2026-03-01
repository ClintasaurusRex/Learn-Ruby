# frozen_string_literal: true

# Exercise 1 solution
def background_job_candidate?(task)
  task[:duration_ms] > 300
end

# Exercise 2 solution
def enqueue(queue, job)
  queue << job
end

# Exercise 3 solution
def dequeue(queue)
  queue.shift
end

# Exercise 4 solution
def worker_message(job)
  "Processed: #{job}"
end

# Exercise 5 solution
def common_job_examples
  ['send_email', 'generate_report', 'sync_webhook']
end

q = []
enqueue(q, 'send_email')
enqueue(q, 'generate_report')
puts worker_message(dequeue(q))
p common_job_examples
