###
  authenticate-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class AuthenticateConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xF7

  @Status =
    SUCCESS: 0x00
    INVALID_PARAMETER: 0x01
    NO_KEY: 0x02
    NO_DATA: 0x03
    INVALID_CHALLENGE: 0x04
    INVALID_MAC: 0x05
    INVALID_KEY: 0x06
    TIMEOUT: 0x07

  constructor: (parser) ->
    super AuthenticateConfirm.OPCODE_GROUP, AuthenticateConfirm.OPCODE
    parser.ieeeAddress "partnerAddress"
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame AuthenticateConfirm

module.exports = AuthenticateConfirm