###
  transport-key-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class TransportKeyIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xF2

  @KeyType =
    TRUST_CENTER_MASTER_KEY: 0x00
    NETWORK_KEY: 0x01
    APPLICATION_MASTER_1_LINK_KEY: 0x02
    APPLICATION_MASTER_2_LINK_KEY: 0x03
    HIGH_SECURITY_NETWORK_KEY: 0x05

  constructor: (parser) ->
    super TransportKeyIndication.OPCODE_GROUP, TransportKeyIndication.OPCODE
    parser.ieeeAddress "srcAddress"
    parser.uint8 "keyType"
    parser.tap () ->
      switch @vars.keyType
        when TransportKeyIndication.KeyType.TRUST_CENTER_MASTER_KEY
          @key "tcMasterKey"
        when TransportKeyIndication.KeyType.NETWORK_KEY
          @uint8 "keySeqNumber"
          @key "networkKey"
        when TransportKeyIndication.KeyType.APPLICATION_MASTER_1_LINK_KEY
          @ieeeAddress "partnerAddress"
          @boolean "initiator"
          @key "key"
        when TransportKeyIndication.KeyType.APPLICATION_MASTER_2_LINK_KEY
          @ieeeAddress "partnerAddress"
          @boolean "initiator"
          @key "key"
        when TransportKeyIndication.KeyType.HIGH_SECURITY_NETWORK_KEY
          @uint8 "keySeqNumber"
          @key "networkKey"
          @boolean "useParent"
          @ieeeAddress "parentAddress"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame TransportKeyIndication

module.exports = TransportKeyIndication