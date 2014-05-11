###
  ztc-reader.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

{EventEmitter} = require "events"
ZtcParser = require "./ztc-parser"
ZtcStream = require "./ztc-stream"

class ZtcReader extends EventEmitter
  constructor: (readable) ->
    @parser = new ZtcParser
    stream = new ZtcStream { mode: ZtcStream.Mode.VERIFY }
    readable.pipe(stream).pipe(@parser)

    @parser.loop () =>
      @parser.ztcFrame "frame"
      @parser.tap () =>
        @emit "frame", @parser.vars.frame
        @parser.vars = {}

module.exports = ZtcReader