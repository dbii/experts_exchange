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

## Robustness

1. Validation on Expert URL, existence, formatting, etc.

## Scalability

1. Save Expert does an inline URL grab and parse
1. Save Expert does an inline URL Shortening

## Future Deprecations

1. Bitly is switching to OAuth from API keys, so that will need to be changed in future versions.


