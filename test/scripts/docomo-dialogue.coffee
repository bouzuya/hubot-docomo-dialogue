{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'docomo-dialogue', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive "hoge"', ->
      beforeEach ->
        @sender = new User 'bouzuya', room: 'hitoridokusho'
        message = 'hoge'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'calls *dialogue* with "hoge"', ->
        assert @callback.callCount is 1
        assert @callback.firstCall.args[0].match.length is 1
        assert @callback.firstCall.args[0].match[0] is 'hoge'
