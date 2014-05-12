###
  ztc-writer.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcBuilder = require "./ztc-builder"
ZtcStream = require "./ztc-stream"

class ZtcWriter
  constructor: (writable) ->
    @writable = new ZtcStream
    @writable.pipe(writable)

  writeFrame: (frame, callback) ->
    buffer = new ZtcBuilder().ztcFrame(frame).result()
    @writable.write buffer, callback

module.exports = ZtcWriter