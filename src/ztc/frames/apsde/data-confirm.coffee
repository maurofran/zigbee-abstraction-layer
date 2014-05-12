###
  data-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class DataConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x00

  @Status =
    SUCCESS: 0x00
    PARTIAL_SUCCESS: 0x05
    SECURITY_FAIL: 0x07
    APS_INVALID_PARAMETER: 0x0A
    ZB_NOT_ON_NETWORK: 0x04
    APS_ILLEGAL_DEVICE: 0x01
    ZB_NO_MEM: 0x02
    APS_ASDU_TOO_LONG: 0xA0
    APS_ILLEGAL_REQUEST: 0xA3
    NO_BOUND_DEVICE: 0xA8
    NO_SHORT_ADDRESS: 0xA9
    APS_TABLE_FULL: 0xAE
    INVALID_REQUEST: 0xC3
    MAX_FRM_COUNTER: 0xCC
    NO_KEY: 0xCD
    BAD_CCM_OUTPUT: 0xCE
    TRANSACTION_OVERFLOW: 0xF1
    TRANSACTION_EXPIRED: 0xF0
    CHANNEL_ACCESS_FAILURE: 0xE1
    INVALID_GTS: 0xE6
    UNAVAILABLE_KEY: 0xF3
    FRAME_TOO_LONG: 0xE5
    FAILED_SECURITY_CHECK: 0xE4
    INVALID_PARAMETER: 0xE8
    NO_ACK: 0xE9

  constructor: (parser) ->
    super DataConfirm.OPCODE_GROUP, DataConfirm.OPCODE
    parser.uint8 "dstAddrMode"
    parser.ieeeAddress "dstAddress"
    parser.uint8 "dstEndpoint"
    parser.uint8 "srcEndpoint"
    parser.uint8 "status"
    parser.moment "txTime"
    parser.uint8 "confirmId"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame DataConfirm

module.exports = DataConfirm