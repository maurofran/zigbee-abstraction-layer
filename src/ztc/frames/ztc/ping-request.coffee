###
  ping-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class PingRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x38

  constructor: (@data) ->
    super PingRequest.OPCODE_GROUP, PingRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 @data.length
    builder.buffer @data

ZtcFrame.registerFrame PingRequest

module.exports = PingRequest