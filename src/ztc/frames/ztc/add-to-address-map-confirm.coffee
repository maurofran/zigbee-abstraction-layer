###
  addtoaddressmapconfirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class AddToAddressMapConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xC0

  constructor: (parser) ->
    super AddToAddressMapConfirm.OPCODE_GROUP, AddToAddressMapConfirm.OPCODE
    parser.uint8 "status"
    parser.tap () =>
      _.assign this, parser.vars

ZtcFrame.registerFrame AddToAddressMapConfirm

module.exports = AddToAddressMapConfirm