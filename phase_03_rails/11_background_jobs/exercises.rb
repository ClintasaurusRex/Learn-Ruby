# frozen_string_literal: true

# Exercise 1: decide if task should be backgrounded.
def background_job_candidate?(task)
  # TODO: return true when task[:duration_ms] > 300
end

# Exercise 2: queue push operation.
def enqueue(queue, job)
  # TODO: append job and return queue
end

# Exercise 3: queue pop operation.
def dequeue(queue)
  # TODO: remove first job
end

# Exercise 4: format worker output.
def worker_message(job)
  # TODO: "Processed: <job>"
end

# Exercise 5: list common job examples.
def common_job_examples
  # TODO: return 3-item array of examples
end
