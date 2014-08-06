# hubot-docomo-dialogue

A Hubot script that calls the [docomo dialogue API](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_docs_id=3).

## Installation

    $ npm install git://github.com/bouzuya/hubot-docomo-dialogue.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-docomo-dialogue.git#TAG'

## Sample Interaction

    bouzuya> こまった
    hubot> どうした
    bouzuya> うるせえ
    hubot> すいません
    bouzuya> 黙れ
    hubot> 黙らない
    bouzuya> 黙れってば
    bouzuya> そこで黙るのかよ

See [`src/scripts/docomo-dialogue.coffee`](src/scripts/docomo-dialogue.coffee) for full documentation.

## License

MIT

## Development

### Run test

    $ npm test

### Run robot

    $ npm run robot


## Badges

[![Build Status][travis-status]][travis]

[travis]: https://travis-ci.org/bouzuya/hubot-docomo-dialogue
[travis-status]: https://travis-ci.org/bouzuya/hubot-docomo-dialogue.svg?branch=master
