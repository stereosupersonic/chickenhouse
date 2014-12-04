[![Stories in Ready](https://badge.waffle.io/stereosupersonic/chickenhouse.png?label=ready&title=Ready)](https://waffle.io/stereosupersonic/chickenhouse)
Chickenhouse
===========
[![Build Status](https://travis-ci.org/stereosupersonic/chickenhouse.png?branch=master)](https://travis-ci.org/stereosupersonic/chickenhouse)
[![Coverage Status](https://coveralls.io/repos/stereosupersonic/chickenhouse/badge.png?branch=master)](https://coveralls.io/r/stereosupersonic/chickenhouse?branch=master)
[![Code Climate](https://codeclimate.com/github/stereosupersonic/chickenhouse.png)](https://codeclimate.com/github/stereosupersonic/chickenhouse)

[This is the source of Henaheisl.de](http://www.henaheisl.de)

## UPDATE
* rake import:flickr                  # pull down all collections from flickr db

## DEPLOY to Heroku
* git push heroku master
* heroku run rake db:migrate
* heroku run rake import:blog
* heroku run rake import:flickr
* heroku run rake import:create_album_posts

Contributor
------------

* Michael Deimel (stereosupersonic) - [m.deimel@deimel.de](mailto:m.deimel@deimel.de)
