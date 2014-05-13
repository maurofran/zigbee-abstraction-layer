###
  establish-key-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class EstablishKeyConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xD5

  @Status =
    SUCCESS: 0x00
    INVALID_PARAMETER: 0x01
    NO_MASTER_KEY: 0x02
    INVALID_CHALLENGE: 0x03
    INVALID_SKG: 0x04
    INVALID_MAC: 0x05
    INVALID_KEY: 0x06
    TIMEOUT: 0x07
    BAD_FRAME: 0x08
    APS_NOT_SUPPORTED: 0x84
    NOT_AUTHORIZED: 0x8D

  constructor: (parser) ->
    super EstablishKeyConfirm.OPCODE_GROUP, EstablishKeyConfirm.OPCODE
    parser.ieeeAddress "address"
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame EstablishKeyConfirm

module.exports = EstablishKeyConfirm