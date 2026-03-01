# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 07: Modules as Mixins" do
  let(:article) { Article.new("Ruby Mixins", "Ada") }

  it "creates slug from title" do
    expect(article.slug).to eq("ruby-mixins")
  end

  it "adds class label via extend" do
    expect(Article.label).to eq("Article")
  end

  it "prepended module uppercases title" do
    expect(LoudArticle.new("Ruby Mixins", "Ada").title).to eq("RUBY MIXINS")
  end

  it "keeps mixin in ancestor chain" do
    expect(Article.ancestors).to include(Slugifiable)
  end

  it "places prepended module before class" do
    expect(LoudArticle.ancestors.first).to eq(UppercaseTitle)
  end
end
