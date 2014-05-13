###
  establish-key-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class EstablishKeyIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xD6

  @Method =
    SKKE: 0x00

  constructor: (parser) ->
    super EstablishKeyIndication.OPCODE_GROUP, EstablishKeyIndication.OPCODE
    parser.ieeeAddress "initiatorAddress"
    parser.uint8 "method"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame EstablishKeyIndication

module.exports = EstablishKeyIndication