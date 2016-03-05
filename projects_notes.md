<!-- NOTE -->
* Use this syntax near code examples to write important and insightful comments.
* We can use this to mark important decisions we've made.

<!-- TODO -->
* beacon for an action item to address in future iterations.



#rspec


```
config.use_transactional_fixtures = true
```
* If the above config parameter is set to false - the test data created will persist to the database.
* Make sure this is set to `true`.

### Transactions

The name of this setting is a bit misleading. What it really means in Rails
is "run every test method within a transaction." In the context of rspec-rails,
it means "run every example within a transaction."

The idea is to start each example with a clean database, create whatever data
is necessary for that example, and then remove that data by simply rolling back
the transaction at the end of the example.
___




#ERRORS
___
ERROR
```
 Magick::ImageMagickError:
       unable to read font `(null)' @ error/annotate.c/RenderFreetype/1239: `(null)'

```

SOLUTION
```
brew install gs
```
___
