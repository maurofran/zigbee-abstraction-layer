###
  radio-register-write-request.coffe
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RadioRegisterWriteRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x39

  constructor: (@address, @value) ->
    super RadioRegisterWriteRequest.OPCODE_GROUP, RadioRegisterWriteRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 3
    builder.uint8 @address
    builder.uint16le @value

ZtcFrame.registerFrame RadioRegisterWriteRequest

module.exports = RadioRegisterWriteRequest