###
  remove-device-indication.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class RemoveDeviceIndication extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xD8

  constructor: (parser) ->
    super RemoveDeviceIndication.OPCODE_GROUP, RemoveDeviceIndication.OPCODE
    parser.ieeeAddress "srcAddress"
    parser.ieeeAddress "childAddress"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame RemoveDeviceIndication

module.exports = RemoveDeviceIndication