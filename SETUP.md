# Setup Guide — Linux Mint 🐧

> Complete step-by-step setup for Ruby 3.2.0, Rails 7.1, and VS Code on Linux Mint.  
> Tested on Linux Mint 21.x (Ubuntu 22.04 base).

---

## Prerequisites

Before starting, make sure you have:

- [ ] Linux Mint 21.x installed (20.x also works)
- [ ] A terminal open (Ctrl + Alt + T)
- [ ] Internet connection
- [ ] At least 2 GB free disk space

---

## Step 1 — Update Your System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## Step 2 — Install Build Dependencies

```bash
sudo apt install -y \
  git curl wget build-essential \
  libssl-dev libreadline-dev zlib1g-dev \
  libsqlite3-dev sqlite3 \
  libffi-dev libyaml-dev \
  nodejs npm
```

---

## Step 3 — Install rbenv

rbenv lets you manage multiple Ruby versions without `sudo`.

```bash
# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

# Add rbenv to your PATH (bash)
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc

# Verify
rbenv --version
# Expected: rbenv 1.x.x
```

> **Tip:** If you use zsh instead of bash, replace `~/.bashrc` with `~/.zshrc`.

---

## Step 4 — Install Ruby 3.2.0

```bash
rbenv install 3.2.0
rbenv global 3.2.0

# Verify
ruby --version
# Expected: ruby 3.2.0 (2022-12-25 revision a528908271) [x86_64-linux]
```

---

## Step 5 — Install Bundler

```bash
gem install bundler
rbenv rehash

# Verify
bundler --version
# Expected: Bundler version 2.x.x
```

---

## Step 6 — Clone and Set Up This Repo

```bash
git clone https://github.com/ClintasaurusRex/Learn-Ruby.git
cd Learn-Ruby
bundle install
```

---

## Step 7 — Install Rails 7.1

```bash
gem install rails -v 7.1
rbenv rehash

# Verify
rails --version
# Expected: Rails 7.1.x
```

---

## Step 8 — Install VS Code

```bash
# Download the .deb package from:
# https://code.visualstudio.com/download

# Or install via snap:
sudo snap install code --classic

# Verify
code --version
```

---

## Step 9 — Install VS Code Extensions

Open VS Code and install these extensions:

| Extension | Publisher | Purpose |
|-----------|-----------|---------|
| Ruby LSP | Shopify | IntelliSense, go-to-definition |
| Ruby | Peng Lv | Syntax highlighting |
| RuboCop | RuboCop | Linting on save |
| GitLens | GitKraken | Git history in editor |
| GitHub Copilot | GitHub | AI pair programming |
| GitHub Copilot Chat | GitHub | Ask questions about your code |

Install via terminal:

```bash
code --install-extension shopify.ruby-lsp
code --install-extension rebornix.ruby
code --install-extension misogi.ruby-rubocop
code --install-extension eamodio.gitlens
```

---

## Step 10 — Configure VS Code for Ruby

Create or update `.vscode/settings.json` in this repo:

```json
{
  "[ruby]": {
    "editor.defaultFormatter": "Shopify.ruby-lsp",
    "editor.formatOnSave": true,
    "editor.tabSize": 2
  },
  "rubyLsp.enabledFeatures": {
    "diagnostics": true,
    "formatting": true,
    "completion": true
  }
}
```

---

## Step 11 — Run the Test Suite

```bash
make test
# or
bundle exec rspec
```

---

## Troubleshooting

### `rbenv: command not found`

```bash
# Make sure rbenv is in your PATH
echo $PATH | grep rbenv

# If not, re-add it
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
```

### `ruby: command not found`

```bash
# Check if rbenv knows about ruby
rbenv versions

# If 3.2.0 is not listed, install it
rbenv install 3.2.0
rbenv global 3.2.0
```

### `gem install` fails with permission denied

```bash
# NEVER use sudo gem install — it bypasses rbenv
# Check that you're using the rbenv ruby, not the system ruby
which ruby
# Should show: /home/yourname/.rbenv/shims/ruby
# If it shows /usr/bin/ruby, your PATH is wrong
```

### `bundle install` fails

```bash
# Make sure you're in the project directory
cd /path/to/Learn-Ruby

# Make sure Ruby 3.2.0 is active
ruby --version

# Clear the bundle cache if needed
bundle clean --force
bundle install
```

### Rails server won't start

```bash
# Check for port conflicts
sudo lsof -i :3000

# Use a different port
rails server -p 3001

# Check the log
tail -f log/development.log
```

### SQLite3 errors on Rails

```bash
# Install the SQLite3 development headers
sudo apt install -y libsqlite3-dev

# Reinstall the gem
gem install sqlite3
bundle install
```

### VS Code doesn't show Ruby autocomplete

```bash
# Make sure Ruby LSP is installed
code --list-extensions | grep ruby

# Reload VS Code window
# Press: Ctrl + Shift + P → "Developer: Reload Window"
```

---

## Verifying Everything Works

Run this checklist:

```bash
ruby --version      # ruby 3.2.0
bundler --version   # Bundler 2.x.x
rails --version     # Rails 7.1.x
git --version       # git 2.x.x
node --version      # v18.x.x or higher
sqlite3 --version   # 3.x.x
```

If all commands return version numbers without errors, you're ready! 🎉

---

## What's Next?

1. Open this repo in VS Code: `code .`
2. Read [docs/LEARNING_PATH.md](docs/LEARNING_PATH.md) for the week-by-week plan
3. Start with lesson 01 in `phase_01_ruby_core/`
4. Use `make lesson N=01` to open a lesson quickly
