# frozen_string_literal: true

# =============================================================================
# rspec_test_template.rb
#
# RSpec test file template demonstrating:
#   - subject / let / let! / before
#   - describe and context blocks
#   - Mocks and stubs
#   - Common matchers
#
# Usage:
#   Copy to spec/models/my_model_spec.rb (or spec/services/, etc.)
#   Replace MyModel with the class you're testing.
#   Run: bundle exec rspec spec/models/my_model_spec.rb
# =============================================================================

require "rails_helper"
# For plain Ruby (non-Rails) use: require "spec_helper"

RSpec.describe MyModel, type: :model do
  # ---------------------------------------------------------------------------
  # subject — the main object being tested.
  # Use described_class so you can rename the class without updating the spec.
  # ---------------------------------------------------------------------------
  subject(:model) { described_class.new(name: "Test", active: true) }

  # ---------------------------------------------------------------------------
  # let — lazy (only evaluated when first used in a test).
  # Use for objects that are shared across examples in this scope.
  # ---------------------------------------------------------------------------
  let(:user)    { create(:user, name: "Alice") }
  let(:account) { create(:account, user: user) }

  # ---------------------------------------------------------------------------
  # let! — eager (evaluated before each test, even if not used).
  # Use when the object must exist in the DB before the test runs.
  # ---------------------------------------------------------------------------
  let!(:existing_record) { create(:my_model, name: "Existing") }

  # ---------------------------------------------------------------------------
  # before — setup that runs before each test in this context.
  # ---------------------------------------------------------------------------
  before do
    user.activate!
    allow(ExternalService).to receive(:call).and_return(true)
  end

  # ---------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:name) }

    context "when name is blank" do
      subject(:model) { described_class.new(name: "") }

      it "is not valid" do
        expect(model).not_to be_valid
        expect(model.errors[:name]).to include("can't be blank")
      end
    end
  end

  # ---------------------------------------------------------------------------
  # Associations (use shoulda-matchers for these)
  # ---------------------------------------------------------------------------
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:items).dependent(:destroy) }
    it { is_expected.to have_one(:profile) }
  end

  # ---------------------------------------------------------------------------
  # Instance methods
  # ---------------------------------------------------------------------------
  describe "#display_name" do
    context "when name is present" do
      it "returns the name" do
        expect(model.display_name).to eq("Test")
      end
    end

    context "when name is nil" do
      subject(:model) { described_class.new(name: nil) }

      it "returns a default" do
        expect(model.display_name).to eq("Unnamed")
      end
    end
  end

  # ---------------------------------------------------------------------------
  # State changes
  # ---------------------------------------------------------------------------
  describe "#activate!" do
    context "when the model is inactive" do
      subject(:model) { create(:my_model, active: false) }

      it "sets active to true" do
        expect { model.activate! }.to change(model, :active).from(false).to(true)
      end

      it "sets activated_at" do
        expect { model.activate! }.to change(model, :activated_at).from(nil)
      end
    end

    context "when already active" do
      it "returns false without changing state" do
        expect(model.activate!).to be(false)
      end
    end
  end

  # ---------------------------------------------------------------------------
  # Class methods / scopes
  # ---------------------------------------------------------------------------
  describe ".active scope" do
    let!(:active_record)   { create(:my_model, active: true) }
    let!(:inactive_record) { create(:my_model, active: false) }

    it "includes active records" do
      expect(described_class.active).to include(active_record)
    end

    it "excludes inactive records" do
      expect(described_class.active).not_to include(inactive_record)
    end
  end

  # ---------------------------------------------------------------------------
  # Mocks — control external dependencies
  # ---------------------------------------------------------------------------
  describe "#sync_with_external_service" do
    context "when the external service succeeds" do
      before do
        allow(ExternalService).to receive(:call).with(model.id).and_return(true)
      end

      it "marks synced as true" do
        model.sync_with_external_service
        expect(model.synced).to be(true)
      end

      it "calls the external service" do
        expect(ExternalService).to receive(:call).with(model.id)
        model.sync_with_external_service
      end
    end

    context "when the external service fails" do
      before do
        allow(ExternalService).to receive(:call).and_raise(ExternalService::Error, "timeout")
      end

      it "does not mark synced as true" do
        model.sync_with_external_service rescue nil
        expect(model.synced).to be(false)
      end

      it "raises an error" do
        expect { model.sync_with_external_service }.to raise_error(ExternalService::Error, "timeout")
      end
    end
  end

  # ---------------------------------------------------------------------------
  # Common matchers demonstrated
  # ---------------------------------------------------------------------------
  describe "matcher examples (remove in real tests)" do
    it "demonstrates common matchers" do
      # Equality
      expect(1 + 1).to eq(2)
      expect("hello").to include("ell")
      expect("hello").to start_with("he")
      expect("hello").to match(/ell/)

      # Collections
      expect([1, 2, 3]).to include(2)
      expect([1, 2, 3]).to contain_exactly(3, 2, 1)
      expect([]).to be_empty

      # Boolean
      expect(true).to be_truthy
      expect(nil).to be_falsy
      expect(nil).to be_nil

      # Types
      expect(model).to be_a(described_class)
      expect(model).to respond_to(:name)
      expect(model).to have_attributes(name: "Test", active: true)
    end
  end
end
