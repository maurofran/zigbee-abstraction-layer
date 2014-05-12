###
  get-device-key-pair-set-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetDeviceKeyPairSetConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x3B

  @ApsKeyType =
    TRUST_CENTER_MASTER_KEY: 0x00
    APPLICATION_MASTER_KEY: 0x02
    APPLICATION_LINK_KEY: 0x03
    TRUST_CENTER_LINK_KEY: 0x04
    NO_APS_LINK_KEY: 0xFC
    RANDOM_TRUST_CENTER_MASTER_KEY: 0xFF

  constructor: (parser) ->
    super GetDeviceKeyPairSetConfirm.OPCODE_GROUP, GetDeviceKeyPairSetConfirm.OPCODE
    parser.ieeeAddress "ieeeAddress"
    parser.uint8 "apsKeyType"
    parser.uint32le "incomingFrameCounter"
    parser.uint32le "outgoingFrameCounter"
    parser.key "apsDeviceKey"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetDeviceKeyPairSetConfirm

module.exports = GetDeviceKeyPairSetConfirm