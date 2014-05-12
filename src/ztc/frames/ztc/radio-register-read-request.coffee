###
  radio-register-read-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RadioRegisterReadRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x3A

  constructor: (@address) ->
    super RadioRegisterReadRequest.OPCODE_GROUP, RadioRegisterReadRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @address

ZtcFrame.registerFrame RadioRegisterReadRequest

module.exports = RadioRegisterReadRequest