###
  get-channel-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetChannelRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x12

  constructor: () ->
    super GetChannelRequest.OPCODE_GROUP, GetChannelRequest.OPCODE

ZtcFrame.registerFrame GetChannelRequest

module.exports = GetChannelRequest