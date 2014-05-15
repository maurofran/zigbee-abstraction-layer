###
  set-frag-ack-mask-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetFragAckMaskRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x12

  constructor: (@fragAckMask) ->
    super SetFragAckMaskRequest.OPCODE_GROUP, SetFragAckMaskRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @fragAckMask

ZtcFrame.registerFrame SetFragAckMaskRequest

module.exports = SetFragAckMaskRequest