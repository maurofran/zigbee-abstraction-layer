###
  get-ep-max-window-size-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetEPMaxWindowSizeRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x09

  constructor: (@number) ->
    super GetEPMaxWindowSizeRequest.OPCODE_GROUP, GetEPMaxWindowSizeRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @number

ZtcFrame.registerFrame GetEPMaxWindowSizeRequest

module.exports = GetEPMaxWindowSizeRequest