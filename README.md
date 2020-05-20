# Forty Web [![CircleCI][badge]][circle]

Forty is one of those boring Rails applications that uses a bit of React when
the interactions are tricky and call for it. It's a fun project and I work hard
to make the code readable and a good example of how I think Rails apps should be
built!

## Install

Start by cloning the project and then run the setup script:

```
$ ./bin/setup
```

This script will ensure you have the requirements and nudge you to setup things
that you don't. Then it'll go through the work of getting your environment setup
and ready to work.

## Start things up

I have a series of scripts I use to start things up but if you just want to boot
Rails you can do this:

```
$ ./bin/server
```

I use tmux to manage the various processes so I end up running something more
like this:

```
# in one window
$ ./bin/server
$ ./bin/webpack-dev-server
$ bundle exec guard

# in another window
$ ./bin/console
$ bundle exec rails db
```

So in the first window I'll have my Rails server and dev webpack server going
with guard setup to reload my browser. Then in the second window I have a Rails
console and a psql console. That's livin' friends!

## Run tests

I have the default rake task setup to run everything:

```
$ bundle exec rake
```

This is how CI runs so that's the best way to ensure you've got a green build
locally.

If you wanted to run them individually, that might look something like this:

```
$ yarn prettier-check && yarn type-check && yarn lint && yarn test && bundle exec rubocop && bundle exec rspec
```

But who has the time to type all that out??

## Deployment

This project is setup to deploy master to staging and then one has to promote
staging to production manually:

```
$ ./bin/promote
```

Or you can just use the Heroku interface too if you want.

## Getting data to play with

I wrote a script for this:

```
$ ./bin/sync_data
```

This task will copy production data to staging and then copy staging data down
to your local database. This isn't something you get to do, it's just for meeee!

[badge]: https://circleci.com/gh/verynicecode/forty-web.svg?style=svg
[circle]: https://circleci.com/gh/verynicecode/forty-web
