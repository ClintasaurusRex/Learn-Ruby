# RSpec Quick Reference ⚡

> Structure, matchers, mocks, shared examples. Scannable in 60 seconds.

---

## Structure

```ruby
# spec/models/post_spec.rb
require 'rails_helper'    # or 'spec_helper' for plain Ruby

RSpec.describe Post, type: :model do
  # subject — what's being tested
  subject(:post) { build(:post) }

  # let — lazy (computed on first use)
  let(:user) { create(:user) }

  # let! — eager (computed before each test)
  let!(:existing) { create(:post) }

  # before — runs before each example
  before { user.confirm! }
  before(:all) { DatabaseCleaner.start }

  # after
  after { cleanup }

  describe "#method_name" do
    context "when condition is true" do
      before { set_condition }

      it "does something" do
        expect(post.result).to eq("expected")
      end

      it { is_expected.to be_valid }  # shorthand
    end

    context "when condition is false" do
      it "behaves differently" do
        expect(post.result).to be_nil
      end
    end
  end
end
```

---

## Common Matchers

```ruby
# Equality
expect(x).to eq(y)          # ==
expect(x).to eql(y)         # eql?
expect(x).to be(y)          # equal? (same object)

# Truthiness
expect(x).to be_truthy
expect(x).to be_falsy
expect(x).to be_nil
expect(x).not_to be_nil

# Comparisons
expect(5).to be > 3
expect(5).to be_between(1, 10)
expect(5).to be_between(1, 10).inclusive

# Types
expect(x).to be_a(String)
expect(x).to be_an_instance_of(User)
expect(x).to respond_to(:name)
expect(x).to have_attributes(name: "Alice", age: 30)

# Strings
expect(s).to include("world")
expect(s).to start_with("Hello")
expect(s).to end_with("!")
expect(s).to match(/pattern/)

# Collections
expect(arr).to include(1)
expect(arr).to contain_exactly(3, 1, 2)   # same elements, any order
expect(arr).to be_empty
expect(arr).to all(be > 0)
expect(arr).to have_attributes(size: 3)

# Changes
expect { post.save }.to change(Post, :count).by(1)
expect { post.destroy }.to change(Post, :count).from(1).to(0)
expect { user.update(name: "Bob") }.to change(user, :name)

# Exceptions
expect { thing.blow_up }.to raise_error(RuntimeError)
expect { thing.blow_up }.to raise_error(RuntimeError, "message")
expect { safe }.not_to raise_error

# Output
expect { puts "hi" }.to output("hi\n").to_stdout

# Rails-specific (shoulda-matchers)
it { is_expected.to validate_presence_of(:title) }
it { is_expected.to belong_to(:user) }
it { is_expected.to have_many(:comments) }
it { is_expected.to have_db_column(:title).of_type(:string) }
```

---

## Mocks and Stubs

```ruby
# Stub — replace with fake return value (no verification)
allow(user).to receive(:admin?).and_return(true)
allow(User).to receive(:find).with(1).and_return(user)
allow(mailer).to receive(:deliver_now)

# Stub with multiple return values
allow(die).to receive(:roll).and_return(1, 2, 3)  # 1 first call, 2 second, etc.

# Stub raising an error
allow(service).to receive(:call).and_raise(NetworkError)

# Mock — stub + verify it WAS called
expect(mailer).to receive(:deliver_now).once
expect(logger).to receive(:info).with("User created")
expect(service).to receive(:call).with(user).and_return(result)

# Times
expect(cache).to receive(:fetch).exactly(2).times
expect(cache).to receive(:fetch).at_least(:once)
expect(cache).to receive(:fetch).at_most(3).times

# Double — fake object
user = double("User", name: "Alice", admin?: false)

# Instance double (verified — method must exist on User)
user = instance_double(User, name: "Alice")

# Spy — verify after the fact
spy_mailer = instance_spy(Mailer)
allow(Mailer).to receive(:new).and_return(spy_mailer)
service.run
expect(spy_mailer).to have_received(:deliver)
```

---

## Shared Examples

```ruby
# Define
RSpec.shared_examples "a publishable" do
  it { is_expected.to respond_to(:publish!) }

  it "becomes published" do
    expect { subject.publish! }.to change(subject, :published).to(true)
  end
end

# Use
RSpec.describe Post do
  it_behaves_like "a publishable"
end

RSpec.describe Article do
  it_behaves_like "a publishable"
end
```

---

## Tagging and Running

```bash
# Run specific files
bundle exec rspec spec/models/post_spec.rb
bundle exec rspec spec/models/post_spec.rb:42   # line 42

# Filters
bundle exec rspec --tag focus
bundle exec rspec --tag ~slow                   # exclude slow

# Formats
bundle exec rspec --format documentation        # verbose
bundle exec rspec --format progress             # dots

# In spec
it "works", :focus do ... end      # tag as focus
it "is slow", :slow do ... end     # tag as slow
xit "skip this" do ... end         # skip (pending)
```

---

## Factory Bot Basics

```ruby
# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    title { "My Post" }
    body  { "Body text" }
    published { false }

    association :user

    trait :published do
      published { true }
      published_at { Time.current }
    end

    trait :draft do
      published { false }
    end
  end
end

# Using factories
create(:post)                    # saved to DB
build(:post)                     # not saved
build_stubbed(:post)             # fake (fastest)
create(:post, :published)        # with trait
create(:post, title: "Custom")   # override
create_list(:post, 3)            # create 3
```

---

## Request Specs

```ruby
RSpec.describe "Posts API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{user.token}" } }

  describe "GET /posts" do
    before { create_list(:post, 3) }

    it "returns all posts" do
      get "/posts", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe "POST /posts" do
    let(:params) { { post: { title: "New", body: "Body" } } }

    it "creates a post" do
      expect {
        post "/posts", params: params, headers: headers
      }.to change(Post, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
```
