###
  set-interframe-delay-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetInterframeDelayRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x15

  constructor: (@interframeDelay) ->
    super SetInterframeDelayRequest.OPCODE_GROUP, SetInterframeDelayRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @interframeDelay

ZtcFrame.registerFrame SetInterframeDelayRequest

module.exports = SetInterframeDelayRequest