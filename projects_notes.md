`<!-- NOTE -->`
* Use this syntax near code examples to write important and insightful comments.
* We can use this to mark important decisions we've made.

`<!-- TODO -->`
* beacon for an action item to address in future iterations.

# rspec

## Questions

```
 # Allows RSpec to persist some state between runs in order to support
 # the `--only-failures` and `--next-failure` CLI options. We recommend
 # you configure your source control system to ignore this file.
```
Q: is it talking about the example.txt file?
___

Q: What is a proxy object?

A proxy interface is such an interface that is implemented by a proxy class. A proxy instance is an instance of a proxy class. Each proxy instance has an associated invocation handler object, which implements the interface InvocationHandler. A dynamic proxy has some overhead.
___

Q: What is a delegate?
* looks like it is a method that returns an object
* therefore delegating the method call to that object?
___

Q: What are some good references for getting started with rspec?

Q: Data is persisting to the database after each test. Presently I am doing this to clear the test data base:

```
after(:all) do
    Fact.delete_all
    Evidence.delete_all
    p Fact.all
    p Evidence.all
  end
  ```

## Tips
__please add tips and tricks about rspec here.__

- _to run tests simply type `rspec` in the console._

```
RAILS_ENV=test rails dbconsole
```
* Open test database
* this is an SQL console

```
RAILS_ENV=test rails console
```
* open test database
* opens rails console in test environment
___

In the testing context:
* Factories are fixtures!
* FactoryGirl creates fixtures.
___
```
let!(:fact) { create(:fact) }
```
* Creates a fact before each tests
* rspec destroy the object after each test.
* `let!` creates the fact before the test
* `let` creates a fact when `:fact` is referenced in a test I.E lazy create.
___

`before(:each)` and `before(:example)` do the same thing:

```
before(:example) # run before each example
```
Check out this reference for more on `before` and `after` hooks
https://www.relishapp.com/rspec/rspec-core/docs/hooks/before-and-after-hooks
___

Nested Factories
```
factory :post do
  title "A title"

  factory :approved_post do
    approved true
  end
end

approved_post = create(:approved_post)
approved_post.title    # => "A title"
approved_post.approved # => true
```
* You can easily create multiple factories for the same class without repeating common attributes by nesting factories:


## References
__please add helpful references about rspec here.__

Great for examples of rspec tests with rails:
https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/models/subscription_spec.rb

Great Guide
http://betterspecs.org/


## Configuration
__please add important details regarding rspec and FactoryGirl configuration here.__
___
```
config.use_transactional_fixtures = true
```
* If the above config parameter is set to false - the test data created will persist to the database.
* Make sure this is set to `true`.

__Q:__ Need some clarity on the best practices for creating and manipulating data in the test environment. When using rspec with factory girl and rails.

__Transactions__

The name of this setting is a bit misleading. What it really means in Rails
is "run every test method within a transaction." In the context of rspec-rails,
it means "run every example within a transaction."

The idea is to start each example with a clean database, create whatever data
is necessary for that example, and then remove that data by simply rolling back
the transaction at the end of the example.
___

```
# spec_helper.rb
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    # Disable the `expect` sytax...
    c.syntax = :should

    # ...or disable the `should` syntax...
    c.syntax = :expect

    # ...or explicitly enable both
    c.syntax = [:should, :expect]
  end
end
```
This shows how to configure rspec to use the `should` syntax or the `expect` syntax, or both.

In our application we disabled the `should` syntax for consistency. And because the `expect` syntax is newer and was implemented as a solution to problems with the old `should` syntax.

To learn more, check out this reference:
http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
__


```
config.disable_monkey_patching!
```

Use the disable_monkey_patching! configuration option to
disable all monkey patching done by RSpec:

stops exposing DSL globally
disables should and should_not syntax for rspec-expectations
disables stub, should_receive, and should_not_receive syntax for rspec-mocks
___




# CODE that needs refactoring to make it more testable



# ERRORS and SOLUTIONS

__Use this section to document the errors you run into, and the solutions you came up with. Add notes about what you've learned and save your team mates a headache!__
___

__ERROR = E__

__SOLUTION = S__


E-1
```
 Magick::ImageMagickError:
       unable to read font `(null)' @ error/annotate.c/RenderFreetype/1239: `(null)'

```

S-1
```
brew install gs
```
___
