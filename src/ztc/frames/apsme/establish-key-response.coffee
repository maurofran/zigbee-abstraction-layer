###
  establish-key-response.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class EstablishKeyResponse extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xD0

  constructor: (@initiatorAddress, @accept) ->
    super EstablishKeyResponse.OPCODE_GROUP, EstablishKeyResponse.OPCODE

  _writePayload: (builder) ->
    builder.uint8 9
    builder.ieeeAddress @initiatorAddress
    builder.boolean @accept

ZtcFrame.registerFrame EstablishKeyResponse

module.exports = EstablishKeyResponse