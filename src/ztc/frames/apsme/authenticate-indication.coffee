###
  authenticate-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class AuthenticateIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xF6

  constructor: (parser) ->
    super AuthenticateIndication.OPCODE_GROUP, AuthenticateIndication.OPCODE
    parser.ieeeAddress "initiatorAddress"
    parser.buffer "randomChallenge", 16
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame AuthenticateIndication

module.exports = AuthenticateIndication