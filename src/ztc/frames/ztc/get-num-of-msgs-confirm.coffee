###
  get-num-of-msgs-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetNumOfMsgsConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x24

  constructor: (parser) ->
    super GetNumOfMsgsConfirm.OPCODE_GROUP, GetNumOfMsgsConfirm.OPCODE
    parser.uint8 "smallBuffers"
    parser.uint8 "bigBuffers"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetNumOfMsgsConfirm

module.exports = GetNumOfMsgsConfirm