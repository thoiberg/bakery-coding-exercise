# bakery-coding-exercise
**NOTE:** This project is currently incomplete and not yet functional

implementing a simulation bakery as a code exercise

## Installation

This repo uses .ruby-gemset and .ruby-version so either RVM or rbenv is recommended.

To install required dependencies run:

```
$ bundle install
```

## Running
To run the application you need to execute the following:

```
$ scripts/bakery <PRODUCT_CODE> <QUANTITY>
```

Where `<PRODUCT_CODE>` is the product code and `<QUANTITY>` is the amount you want to purchase.

you can look in `config/config.yaml` for a list of products and their codes.

## Tests

To run the tests you need to execute the following:

```
$ bundle exec rspec
```
