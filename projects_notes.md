`<!-- NOTE -->`
* Use this syntax near code examples to write important and insightful comments.
* We can use this to mark important decisions we've made.

`<!-- TODO -->`
* beacon for an action item to address in future iterations.

# rspec

## Tips
__please add tips and tricks about rspec here.__

- _to run tests simply type `rspec` in the console._

## References
__please add helpful references about rspec here.__

Great for examples of rspec tests with rails:
https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/models/subscription_spec.rb


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

# CODE that needs refactoring to make it more testable

#### Fact#update_score

```
def update_score
   num_votes = evidences.inject(0) do |sum, evidence|
     sum += evidence.upvotes + evidence.downvotes
   end

   return if num_votes == 0

   vote_sums = evidences.inject(0) do |sum, evidence|
     sum += if evidence.support
              evidence.upvotes # upvotes on supporting evidence are good for a fact
            else
              evidence.downvotes # downvotes on refuting evidence are good for a fact
            end
   end

   self.score = (vote_sums.to_f / num_votes.to_f * 100).round

   save

   update_image
 end
 ```
 This method returns whatever `update_image` returns. Which makes it very hard to test.

 We should consider refactoring so the method returns the newly updated score.

 This way, we can do something like this in a test:

 ```
 expect(@fact.update_score)to. eq 50
 ```

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
