.PHONY: setup test lesson project docs help

# Default target
help:
	@echo ""
	@echo "Learn-Ruby Makefile"
	@echo "==================="
	@echo ""
	@echo "Usage:"
	@echo "  make setup          Install dependencies"
	@echo "  make test           Run all RSpec tests"
	@echo "  make lesson N=01    Open lesson 01 in VS Code"
	@echo "  make project N=1    Open project 1 in VS Code"
	@echo "  make docs           Open docs folder in VS Code"
	@echo "  make help           Show this help message"
	@echo ""

# Install all dependencies
setup:
	@echo "→ Installing Ruby gems..."
	bundle install
	@echo "✓ Setup complete!"

# Run all tests
test:
	@echo "→ Running RSpec tests..."
	bundle exec rspec --format documentation
	@echo "✓ Tests complete!"

# Open a specific lesson (usage: make lesson N=01)
lesson:
ifndef N
	$(error N is required. Usage: make lesson N=01)
endif
	@LESSON_DIR=$$(find . -type d -name "*$(N)*" ! -path "*/\.*" | head -1); \
	if [ -z "$$LESSON_DIR" ]; then \
		echo "✗ Lesson $(N) not found"; \
		exit 1; \
	fi; \
	echo "→ Opening lesson $(N): $$LESSON_DIR"; \
	code "$$LESSON_DIR"

# Open a specific project (usage: make project N=1)
project:
ifndef N
	$(error N is required. Usage: make project N=1)
endif
	@PROJECT_DIR=$$(find . -type d -name "*project*$(N)*" ! -path "*/\.*" | head -1); \
	if [ -z "$$PROJECT_DIR" ]; then \
		echo "✗ Project $(N) not found"; \
		exit 1; \
	fi; \
	echo "→ Opening project $(N): $$PROJECT_DIR"; \
	code "$$PROJECT_DIR"

# Open docs folder
docs:
	@echo "→ Opening docs folder..."
	code docs/
