# Testing Reference 🧪

> Complete guide to testing with RSpec.

---

## Mental Model — RSpec Structure

```
┌───────────────────────────────────────────────────────────┐
│                  RSPEC STRUCTURE                          │
│                                                           │
│  describe "outer context" do                              │
│    let(:user) { create(:user) }                           │
│    subject { described_class.new(user) }                  │
│                                                           │
│    before { do_some_setup }                               │
│                                                           │
│    context "when condition is true" do                    │
│      before { set_condition_true }                        │
│                                                           │
│      it "does something specific" do                      │
│        expect(subject.result).to eq("expected value")     │
│      end                                                  │
│    end                                                    │
│                                                           │
│    context "when condition is false" do                   │
│      it "behaves differently" do                          │
│        expect(subject.result).to be_nil                   │
│      end                                                  │
│    end                                                    │
│  end                                                      │
└───────────────────────────────────────────────────────────┘
```

---

## RSpec Setup

```ruby
# spec/spec_helper.rb
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Run tests
bundle exec rspec                    # all
bundle exec rspec spec/models/       # one directory
bundle exec rspec spec/models/post_spec.rb  # one file
bundle exec rspec spec/models/post_spec.rb:42  # one line
```

---

## 20+ Matchers with Examples

### Equality and Identity

```ruby
expect(1 + 1).to eq(2)              # == (value equality)
expect(obj).to be(other_obj)        # equal? (same object)
expect("hello").to eql("hello")     # eql? (type + value)
```

### Truthiness

```ruby
expect(true).to be_truthy
expect(false).to be_falsy
expect(nil).to be_nil
expect(value).to be_present   # Rails: not nil/blank/empty
```

### Comparison

```ruby
expect(5).to be > 3
expect(5).to be >= 5
expect(5).to be < 10
expect(5).to be_between(1, 10)
expect(5).to be_between(1, 10).inclusive
```

### Strings

```ruby
expect("hello world").to include("world")
expect("hello").to start_with("he")
expect("hello").to end_with("lo")
expect("hello123").to match(/\d+/)
```

### Arrays and Collections

```ruby
expect([1, 2, 3]).to include(2)
expect([1, 2, 3]).to include(1, 3)
expect([1, 2, 3]).to contain_exactly(3, 1, 2)  # same elements, any order
expect([1, 2, 3]).to match_array([3, 1, 2])     # same as contain_exactly
expect([1, 2, 3]).to have(3).items              # needs shoulda-matchers
expect([]).to be_empty
expect([1, 2, 3]).to all(be > 0)
```

### Objects and Types

```ruby
expect(user).to be_a(User)
expect(user).to be_an_instance_of(User)
expect(User).to be_a(Class)
expect(user).to respond_to(:name)
expect(user).to respond_to(:name, :email)
expect(user).to have_attributes(name: "Alice", age: 30)
```

### Exceptions

```ruby
expect { Post.find(0) }.to raise_error(ActiveRecord::RecordNotFound)
expect { raise "oops" }.to raise_error(RuntimeError, "oops")
expect { safe_method }.not_to raise_error
```

### Changes

```ruby
expect { Post.create(title: "Hi") }.to change(Post, :count).by(1)
expect { post.destroy }.to change(Post, :count).from(1).to(0)
expect { user.update(name: "Bob") }.to change(user, :name).from("Alice").to("Bob")
```

---

## let, before, subject

```ruby
describe Post do
  # subject — the object being tested
  subject(:post) { described_class.new(title: "Hello") }

  # let — lazy evaluation (computed on first use)
  let(:user) { create(:user, name: "Alice") }
  let(:post) { create(:post, user: user) }

  # let! — eager evaluation (computed before each test)
  let!(:existing_post) { create(:post) }

  # before — runs before each example
  before { user.activate! }
  before(:all) { seed_database }  # runs once before all examples

  it "has a title" do
    expect(post.title).to eq("Hello")
  end
end
```

---

## Mocks and Stubs

```ruby
# Stub a method (replace with a fake return value)
allow(user).to receive(:admin?).and_return(true)
allow(User).to receive(:find).and_return(user)
allow(mailer).to receive(:deliver_now).and_return(nil)

# Stub with arguments
allow(user).to receive(:greet).with("Alice").and_return("Hi Alice!")

# Mock (stub + verify it was called)
expect(mailer).to receive(:deliver_now).once
expect(user).to receive(:save).and_return(true)
expect(logger).to receive(:info).with(/created/)

# Spy (verify after the fact)
spy = instance_spy(Mailer)
allow(Mailer).to receive(:new).and_return(spy)
# ... run code ...
expect(spy).to have_received(:deliver)

# Double (fake object)
user = double("User", name: "Alice", admin?: false)
user.name    # => "Alice"

# Instance double (verified double — checks method exists)
user = instance_double(User, name: "Alice")
```

---

## Model Specs

```ruby
# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { build(:post) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(200) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe "#publish!" do
    let(:post) { create(:post, published: false) }

    context "when post is valid" do
      it "marks post as published" do
        expect { post.publish! }.to change(post, :published).to(true)
      end

      it "sets published_at" do
        expect { post.publish! }.to change(post, :published_at).from(nil)
      end
    end
  end

  describe ".published scope" do
    let!(:published_post) { create(:post, published: true) }
    let!(:draft_post)     { create(:post, published: false) }

    it "returns only published posts" do
      expect(Post.published).to include(published_post)
      expect(Post.published).not_to include(draft_post)
    end
  end
end
```

---

## Request Specs

```ruby
# spec/requests/posts_spec.rb
require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before { sign_in user }

  describe "GET /posts" do
    it "returns a successful response" do
      get posts_path
      expect(response).to have_http_status(:ok)
    end

    it "displays posts" do
      post
      get posts_path
      expect(response.body).to include(post.title)
    end
  end

  describe "POST /posts" do
    let(:valid_params) { { post: { title: "New Post", body: "Body text" } } }

    it "creates a post" do
      expect {
        post posts_path, params: valid_params
      }.to change(Post, :count).by(1)
    end

    it "redirects to the new post" do
      post posts_path, params: valid_params
      expect(response).to redirect_to(post_path(Post.last))
    end

    context "with invalid params" do
      it "renders new with error" do
        post posts_path, params: { post: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
```

---

## System Specs

```ruby
# spec/system/posts_spec.rb
require 'rails_helper'

RSpec.describe "Creating a post", type: :system do
  let(:user) { create(:user) }

  before { sign_in user }

  it "allows a user to create a post" do
    visit new_post_path

    fill_in "Title", with: "My New Post"
    fill_in "Body",  with: "This is the body"
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    expect(page).to have_content("My New Post")
  end
end
```

**Checklist:**
- [ ] I can write a basic describe/context/it structure
- [ ] I know how to use let, let!, and before
- [ ] I can use 10+ matchers correctly
- [ ] I can stub a method with `allow(...).to receive(...)`
- [ ] I can verify a method was called with `expect(...).to receive(...)`
- [ ] I can write model specs that test validations and methods
- [ ] I can write request specs that test HTTP responses

**Common mistakes:**
- Using `before(:all)` when you mean `before(:each)` — state leaks between tests
- Stubbing too much — if you stub everything, you're not testing anything
- Not using `let!` when you need the record to exist before the test
- Testing implementation details instead of behavior
