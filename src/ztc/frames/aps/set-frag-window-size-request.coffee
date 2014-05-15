###
  set-frag-window-size-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetFragWindowSizeRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x14

  constructor: (@windowSize) ->
    super SetFragWindowSizeRequest.OPCODE_GROUP, SetFragWindowSizeRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @windowSize

ZtcFrame.registerFrame SetFragWindowSizeRequest

module.exports = SetFragWindowSizeRequest