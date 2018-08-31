# README

## Configuration

- Ruby 2.4.4
- Rails 2.5.2
- postgresql

### ENV file

Create a .env file with the following values:

`SHORTENER_USERNAME`

the bitly USERNAME on the account for the API key

`SHORTENER_API_KEY`

the bitly API key.

## Services

### URL Shortening

We use bitly for URL shortening since goo.gl is being deprecated.

## Testing

Testing uses rspec:

`rspec spec`

## URL Fetching and Parsing

We use open-uri with Nokogiri for URL fetching and parsing

# TODO

## Features

3. Friend setup
3. search
2. Node walking

## Robustness Concerns

1. Validation on Expert URL, existence, formatting, etc. Currently we just assume URL will be good, valid, and parsable.
1. Expert Topics: There is minor cleanup of topics. Need to review common words and phrases and filter out high frequency non-relevant ones, or whatever handling needs to be done. Switch from word list to method for better handling.
2. Expert Search: This is rudimentary by most standards. Postgres has built in full text search, but we thought that hid too much of the search algorithm (as per instructions). Ranked searching would be good, count up number of hits and then sort by relevance, maybe with a weight for the H1..H3 level in there. There are also engines like Elastisearch and Sphinx that handle the hard parts (and work with word stems, plurals, etc.) but those seemed to be prohibited by the instruction. All of which really says writing your own search from basic principals is "hard" to get it right, when you can leverage what the bigger players are doing.
3. Expert Path: We wrote our own, but there is database recursion in postgres and other ways to do a better more complete node path. Depending on scale, a graph database for the relationships might be better.
4. Friendship: We did a simple expert 1 to expert 2 model. In working on this we debated a two way model which has an expert and friend, and you would have to converse for your friend (a record I am an expert and you're my friend, and a record where you are the expert and I am the friend.). That solves some of the problem of searching, but introduces scaling issues of maintaining a consistent set of dual records for each edge between nodes, but it is worth considering.

## Scalability Issues

1. Save Expert does an inline URL grab and parse
1. Save Expert does an inline URL Shortening

## Future Deprecations

1. Bitly is switching to OAuth from API keys, so that will need to be changed in future versions.


