json.title truncate(@fact.body, length: 80)
json.truthiness @fact.score
json.popularity @fact.total_votes
json.category @fact.category.name
