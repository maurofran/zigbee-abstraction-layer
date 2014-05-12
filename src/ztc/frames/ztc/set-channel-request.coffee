###
  set-channel-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class SetChannelRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x13

  constructor: (@channel) ->
    super SetChannelRequest.OPCODE_GROUP, SetChannelRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @channel

ZtcFrame.registerFrame SetChannelRequest

module.exports = SetChannelRequest