###
  getpanidconfirm.js
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetPanIdConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x14

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super GetPanIdConfirm.OPCODE_GROUP, GetPanIdConfirm.OPCODE
    parser.uint8 "status"
    parser.panId "panId"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetPanIdConfirm

module.exports = GetPanIdConfirm