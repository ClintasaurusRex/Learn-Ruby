# Project 02: OOP Task Manager

## Goal
Build a CLI-based task manager using Ruby OOP patterns with inheritance, composition, and JSON persistence.

## Class Diagram (ASCII)

```text
+-------------------+
| Entity            |
| - id              |
| - title           |
+---------+---------+
          ^
          |
+---------+---------+        +----------------------+
| Task              |        | TaskCollection       |
| - status          |<------>| - tasks (Array<Task>)|
| - due_date        |        | + add/remove/find    |
+---------+---------+        +----------+-----------+
          ^                             |
          |                             v
+---------+---------+        +----------------------+
| RecurringTask     |        | JsonStore            |
| - interval_days   |        | + load/save          |
| + next_due_date   |        +----------+-----------+
+-------------------+                   |
                                        v
                               +----------------------+
                               | TaskManager          |
                               | (composition root)   |
                               +----------+-----------+
                                          |
                                          v
                               +----------------------+
                               | CLI                  |
                               +----------------------+
```

## Architecture Diagram (ASCII)

```text
CLI Command -> CLI Parser -> TaskManager -> TaskCollection -> JsonStore -> tasks.json
                                |
                                +-> Task / RecurringTask behavior
```

## Design Decisions (Plain Language)
- **Inheritance**: `RecurringTask` extends `Task` to add recurring behavior.
- **Composition**: `TaskManager` composes a `TaskCollection` and `JsonStore`.
- **Single responsibility**: storage, task logic, and command parsing are split.
- **JSON persistence**: easy to inspect manually and common in small tools.

## How this maps to real-world use
This models production task systems where business objects (tasks), storage layers, and command interfaces are separated so teams can add features without rewriting everything.

## Step-by-step run instructions (Linux Mint)
1. Open terminal:
   ```bash
   cd projects/project_02_oop_task_manager
   ```
2. Add a task:
   ```bash
   ruby src/task_manager.rb add "Pay rent" --due 2026-03-05
   ```
3. Add a recurring task:
   ```bash
   ruby src/task_manager.rb add-recurring "Weekly review" --due 2026-03-01 --interval 7
   ```
4. List tasks:
   ```bash
   ruby src/task_manager.rb list
   ```
5. Run tests:
   ```bash
   bundle exec rspec tests/task_manager_spec.rb
   ```

## Refactor challenge
Refactor the CLI parser so each command is an object (`AddCommand`, `ListCommand`, etc.) and compare readability vs. the current branching approach.
