###
  data-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class DataIndication extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x01

  @AddressMode =
    RESERVED: 0x00
    VALUE_16BIT_GROUP_FOR_DST_ADDR: 0x01
    VALUE_16BIT_ADDR_AND_DST_ENDPOINT: 0x02

  @SecurityStatus =
    UNSECURED: 0x00
    SECURED_NWK_KEY: 0x01
    SECURED_LINK_KEY: 0x02
    SECURED_LINK_AND_NWK_KEY: 0x03

  @Status =
    SUCCESS: 0x00
    DEFRAG_DEFERRED: 0xA1
    DEFRAG_UNSUPPORTED: 0xA2

  constructor: (parser) ->
    super DataIndication.OPCODE_GROUP, DataIndication.OPCODE
    parser.uint8 "dstAddrMode"
    parser.shortAddress "dstAddress"
    parser.uint8 "dstEndpoint"
    parser.uint8 "srcAddrMode"
    parser.shortAddress "srcAddress"
    parser.uint8 "srcEndpoint"
    parser.uint16le "profileId"
    parser.uint16le "clusterId"
    parser.uint8 "asduLength"
    parser.tap () -> @buffer "asdu", @vars.asduLength
    parser.uint8 "status"
    parser.boolean "wasBroadcast"
    parser.uint8 "securityStatus"
    parser.uint8 "linkQuality"
    parser.moment "rxTime"
    parser.uint8 "messageType"
    parser.uint16le "nextBlock"
    parser.uint8 "dataSize"
    parser.uint16le "dataPointer"
    parser.uint8 "bufferNumber"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame DataIndication

module.exports = DataIndication