# Glossary 📖

> 40+ plain-language definitions for Ruby, OOP, and Rails terms.

---

## Ruby Terms

**Block**  
A chunk of code passed to a method, written with `{ }` or `do...end`. The method decides when and if to run it. Example: `[1,2,3].each { |n| puts n }`.

**Bundler**  
A tool that manages your Ruby gem dependencies. Reads `Gemfile`, installs the right gem versions, and records them in `Gemfile.lock` so everyone uses the same versions.

**Closure**  
A block, proc, or lambda that "remembers" the variables from where it was defined, even after that scope is gone. In Ruby, blocks are closures.

**Enumerable**  
A module that provides collection methods like `map`, `select`, `reject`, `find`, `reduce`. Any class that defines `each` can include Enumerable and get all these methods for free.

**Freeze**  
Making an object immutable with `.freeze`. Frozen objects cannot be modified. String literals with `# frozen_string_literal: true` are automatically frozen in Ruby 3+.

**Gem**  
A packaged Ruby library that you can install and use in your projects. Gems are hosted on rubygems.org and managed with Bundler.

**Hash**  
A collection of key-value pairs. Keys are usually symbols. Example: `{ name: "Alice", age: 30 }`. Also called a dictionary or map in other languages.

**Lambda**  
A proc that strictly checks argument count and has its own return scope (returning from a lambda only exits the lambda, not the surrounding method).

**Method missing**  
A special Ruby method called when an object receives a message it doesn't understand. Used in metaprogramming to dynamically handle undefined methods.

**Module**  
A namespace for grouping methods and constants. Can be included in classes to add shared behavior (mixin). Cannot be instantiated directly.

**Mixin**  
A module included in a class to add methods to it. Ruby's way of sharing behavior without inheritance. Example: `include Comparable`.

**nil**  
Ruby's "nothing" object. It's an instance of `NilClass`. Only `nil` and `false` are falsy in Ruby.

**Object**  
Everything in Ruby is an object — integers, strings, nil, true, false, classes, even methods. Every object has a class and responds to methods.

**Proc**  
A saved block. You can store it in a variable and call it later. Less strict than a lambda about argument count and has different return behavior.

**Range**  
Represents a sequence of values between a start and end. `(1..10)` is inclusive, `(1...10)` excludes the end. Works with `each`, `include?`, etc.

**Symbol**  
An immutable identifier written with a colon prefix (`:name`). Only one copy of each symbol exists in memory. Used as hash keys and method references.

**Truthiness**  
In Ruby, only `false` and `nil` are falsy. Everything else — including `0`, `""`, and `[]` — is truthy. This differs from many other languages.

**Yield**  
The keyword that passes control to the block given to a method. `yield(value)` passes a value to the block.

---

## OOP Terms

**Abstract class**  
A class meant to be subclassed, not instantiated directly. Ruby doesn't have official abstract classes, but you can raise `NotImplementedError` in methods to enforce subclassing.

**Accessor**  
A method that reads (`attr_reader`) or writes (`attr_writer`) an instance variable. `attr_accessor` creates both. They're shorthand for writing getter/setter methods.

**Class**  
A blueprint for creating objects. Defines the attributes (state) and methods (behavior) that its instances will have.

**Class method**  
A method called on the class itself, not on instances. Defined with `def self.method_name`. Example: `User.find(1)`, `Post.create(...)`.

**Composition**  
Building complex objects by combining simpler ones ("has-a" relationship). An alternative to inheritance that often produces more flexible, testable code.

**Duck typing**  
"If it walks like a duck and quacks like a duck, it's a duck." Ruby doesn't care about an object's class, only whether it responds to the required methods.

**Encapsulation**  
Hiding an object's internal details and exposing only what's necessary through a public interface. Controlled with `public`, `protected`, and `private`.

**Inheritance**  
A class can inherit methods and attributes from a parent class using `<`. Example: `class Dog < Animal`. Ruby supports single inheritance only.

**Instance**  
A single object created from a class. `fido = Dog.new("Fido")` — `fido` is an instance of `Dog`.

**Instance variable**  
A variable that belongs to a specific object, prefixed with `@`. Each instance has its own copy. Example: `@name`.

**Interface**  
In Ruby (which has no formal interfaces), an interface is the set of public methods an object responds to. Duck typing relies on informal interfaces.

**Polymorphism**  
The ability of different objects to respond to the same method call in their own way. Enables writing code that works with objects of different classes.

**Singleton method**  
A method defined on a single object, not its class. `def fido.roll_over; "rolling"; end` — only `fido` can call `roll_over`.

**super**  
Calls the same method in the parent class. Used in subclasses to extend (rather than replace) parent behavior.

---

## Rails Terms

**ActionController**  
The base class for all Rails controllers. Handles request/response, before actions, redirects, rendering, params, sessions, and flash.

**ActionRecord**  
See: ActiveRecord.

**ActiveRecord**  
Rails' ORM (Object-Relational Mapper). Connects Ruby model classes to database tables and provides methods for querying and modifying data.

**Asset pipeline**  
Rails system for managing CSS, JavaScript, and images. Compiles, concatenates, and fingerprints assets for production deployment.

**Before action**  
A controller callback that runs before one or more actions. Used for authentication, loading records, etc. Defined with `before_action :method_name`.

**Callback**  
Code that runs automatically at specific points in an object's lifecycle. In ActiveRecord: `before_save`, `after_create`, etc.

**Controller**  
Handles HTTP requests, orchestrates interaction between models and views, and sends responses. Should be thin — minimal logic.

**CSRF**  
Cross-Site Request Forgery. An attack where malicious sites trick your browser into making requests to your app. Rails protects against it with authenticity tokens.

**ERB**  
Embedded Ruby. The template language used in Rails views. Ruby code runs inside `<% %>` tags, and `<%= %>` outputs the result.

**Flash**  
A special session hash for storing messages that persist for exactly one request. Used for success/error notices: `flash[:notice] = "Post created!"`.

**Gemfile.lock**  
Auto-generated file that records the exact version of every gem installed. Ensures all developers use the same versions. Never edit manually.

**Migration**  
A Ruby file that describes a change to the database schema (create table, add column, etc.). Run with `rails db:migrate`. Keeps schema changes in version control.

**Model**  
Represents a database table and contains business logic. Inherits from `ApplicationRecord`. Handles validations, associations, queries, and data manipulation.

**Params**  
The hash of all data sent with a request: URL parameters, form data, and JSON body. Accessed in controllers as `params[:key]`. Filtered with strong parameters.

**Route**  
A mapping from an HTTP verb + URL path to a controller action. Defined in `config/routes.rb`.

**Scaffold**  
A generator that creates a complete CRUD interface: model, migration, controller, views, routes, and tests. `rails generate scaffold Post title:string body:text`.

**Scope**  
A named ActiveRecord query defined in a model. Example: `scope :published, -> { where(published: true) }`. Chainable.

**Service object**  
A plain Ruby class that encapsulates a complex business operation. Keeps controllers and models thin. Usually called with `.call(args)`.

**Strong parameters**  
A Rails security feature that requires explicitly listing which params are allowed before passing them to the model. Prevents mass assignment vulnerabilities.

**View**  
An ERB template that generates the HTML (or JSON) response. Should contain only display logic, not business logic.
