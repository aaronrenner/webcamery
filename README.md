# Webcamery

[![Build
Status](https://semaphoreci.com/api/v1/projects/b69c713a-4a4f-4e89-b3cd-1fab41581b7f/661481/badge.svg)](https://semaphoreci.com/aaronrenner/webcamery)

A gallery to show all of your webcams to your friends.

## Getting Started

After you have cloned this repo, run the setup script to set up your machine
with the necessary dependencies to run and test this app:

    $ ./bin/setup

After setting up, you can run the application using [Heroku Local]:

    $ heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running Tests

Make sure you have phantomjs webdriver running

    $ phantomjs --wd

Then run

    $ mix test
