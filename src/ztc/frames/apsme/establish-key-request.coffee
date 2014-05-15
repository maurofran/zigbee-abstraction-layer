###
  establish-key-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class EstablishKeyRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xCF

  @Method =
    SKKE: 0x00

  constructor: (@responderAddress, @useParent, @responderParentAddress, @method) ->
    super EstablishKeyRequest.OPCODE_GROUP, EstablishKeyRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 18
    builder.ieeeAddress @responderAddress
    builder.boolean @useParent
    builder.ieeeAddress @responderParentAddress
    builder.uint8 @method

ZtcFrame.registerFrame EstablishKeyRequest

module.exports = EstablishKeyRequest