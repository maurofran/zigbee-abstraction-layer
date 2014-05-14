###
  switch-key-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SwitchKeyRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xD4

  constructor: (@destAddress, @keySeqNumber) ->
    super SwitchKeyRequest.OPCODE_GROUP, SwitchKeyRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 9
    builder.ieeeAddress @destAddress
    builder.uint8 @keySeqNumber

ZtcFrame.registerFrame SwitchKeyRequest

module.exports = SwitchKeyRequest