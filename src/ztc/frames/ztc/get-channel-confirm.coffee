###
  get-channel-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetChannelConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x12

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super GetChannelConfirm.OPCODE_GROUP, GetChannelConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "channel"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetChannelConfirm

module.exports = GetChannelConfirm