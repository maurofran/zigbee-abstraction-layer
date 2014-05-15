###
  unbind-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class UnbindConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0x08

  @Status =
    SUCCESS: 0x00
    ILLEGAL_DEVICE: 0x01
    ILLEGAL_REQUEST: 0xA3
    INVALID_BINDING: 0x03
    BIND_TABLE_FULL: 0xAE
    NOT_SUPPORTED: 0x09
    INVALID_PARAMETER: 0x0A
    APS_NOT_SUPPORTED: 0x84

  constructor: (parser) ->
    super UnbindConfirm.OPCODE_GROUP, UnbindConfirm.OPCODE
    parser.uint8 "status"
    parser.ieeeAddress "srcAddress"
    parser.uint8 "srcEndpoint"
    parser.uint16le "clusterId"
    parser.uint8 "dstAddrMode"
    parser.ieeeAddress "dstAddress"
    parser.uint8 "dstEndpoint"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame UnbindConfirm

module.exports = UnbindConfirm