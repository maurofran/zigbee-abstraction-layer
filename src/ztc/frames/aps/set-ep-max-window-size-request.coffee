###
  set-ep-max-window-size-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetEPMaxWindowSizeRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x0F

  constructor: (@number, @windowSize) ->
    super SetEPMaxWindowSizeRequest.OPCODE_GROUP, SetEPMaxWindowSizeRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 2
    builder.uint8 @number
    builder.uint8 @windowSize

ZtcFrame.registerFrame SetEPMaxWindowSizeRequest

module.exports = SetEPMaxWindowSizeRequest