###
  update-device-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class UpdateDeviceIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xD7

  @Status =
    SECURED_JOIN: 0x00
    UNSECURED_JOIN: 0x01
    LEFT: 0x02

  constructor: (parser) ->
    super UpdateDeviceIndication.OPCODE_GROUP, UpdateDeviceIndication.OPCODE
    parser.ieeeAddress "srcAddress"
    parser.ieeeAddress "deviceAddress"
    parser.shortAddress "deviceShortAddress"
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame UpdateDeviceIndication

module.exports = UpdateDeviceIndication