###
  set-device-key-pair-set-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class SetDeviceKeyPairSetConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x3E

  @Status =
    SUCCESS: 0x00
    TABLE_FULL: 0x0B1

  constructor: (parser) ->
    super SetDeviceKeyPairSetConfirm.OPCODE_GROUP, SetDeviceKeyPairSetConfirm.OPCODE
    parser.uint8 "apsSetStatus"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame SetDeviceKeyPairSetConfirm

module.exports = SetDeviceKeyPairSetConfirm