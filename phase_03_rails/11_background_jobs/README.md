# Lesson 11 — Background Jobs

## 1) Concept Overview
Background jobs move slow work out of the web request so users get fast responses while work completes asynchronously.

## 2) Mental Model
```
Job queue flow

Web request
  -> enqueue job
  -> respond 202/redirect quickly

Queue -> Worker pulls job -> perform work -> mark done/retry

Use background jobs when work is:
- slow (email, reports, imports)
- retryable
- not required for immediate response
```

## 3) Starter Code shown
```ruby
# frozen_string_literal: true

class Queue
  def initialize
    @jobs = []
  end

  def enqueue(job)
    # TODO: push job
  end
end
```

## 4) You Type This
- Open `starter.rb`.
- Enqueue two jobs.
- Implement worker loop.
- Print processed job names.

## 5) Expand the Example
Add retry tracking and dead-letter handling for jobs that fail repeatedly.

## 6) Real-World Application
Use Sidekiq/ActiveJob for emails, webhooks, exports, and billing sync. Keep request paths focused on quick validations and enqueueing.

## 7) Checklist (before moving on)
- [ ] I know why queueing improves request latency.
- [ ] I can identify retryable work.
- [ ] I can separate immediate vs deferred tasks.
- [ ] I can reason about idempotent jobs.
- [ ] I can monitor queue depth.

## 8) Common Mistakes
- Doing heavy work synchronously in controllers.
- Making jobs non-idempotent.
- No retry/backoff strategy.

## 9) Debug Flow
- Confirm job is enqueued.
- Check worker consumption.
- Inspect failures and retry count.

## 10) Stretch Goal + sample output
Add an exponential backoff schedule and stop retrying after 3 attempts.

Sample output:
```
Processed: SendWelcomeEmail
Processed: GenerateWeeklyReport
```
