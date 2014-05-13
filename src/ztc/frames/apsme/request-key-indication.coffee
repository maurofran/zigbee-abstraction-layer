###
  request-key-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class RequestKeyIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xD9

  @KeyType =
    NETWORK_KEY: 0x01
    APPLICATION_KEY: 0x02

  constructor: (parser) ->
    super RequestKeyIndication.OPCODE_GROUP, RequestKeyIndication.OPCODE
    parser.ieeeAddress "srcAddress"
    parser.uint8 "keyType"
    parser.ieeeAddress "partnerAddress"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame RequestKeyIndication

module.exports = RequestKeyIndication