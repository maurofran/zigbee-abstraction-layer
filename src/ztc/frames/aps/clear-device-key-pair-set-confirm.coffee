###
  clear-device-key-pair-set-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ClearDeviceKeyPairSetConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x3F

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super ClearDeviceKeyPairSetConfirm.OPCODE_GROUP, ClearDeviceKeyPairSetConfirm.OPCODE
    parser.uint8 "apsSetStatus"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ClearDeviceKeyPairSetConfirm

module.exports = ClearDeviceKeyPairSetConfirm