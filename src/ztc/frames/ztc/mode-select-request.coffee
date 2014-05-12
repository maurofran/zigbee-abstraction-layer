###
  mode-select-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ModeSelectRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x00

  @Mode =
    DISABLE: 0x00
    HOOK: 0x01
    MONITOR: 0x02

  constructor: (@uartTxBlocking, @mcpsMode, @mlmeMode, @aspMode, @nldeMode, @nlmeMode, @apsdeMode, @afdeMode,
                @apsmeMode, @zdpMode) ->
    super ModeSelectRequest.OPCODE_GROUP, ModeSelectRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 10
    builder.uint8 @uartTxBlocking ? 0x01 : 0x00
    builder.uint8 @mcpsMode
    builder.uint8 @mlmeMode
    builder.uint8 @aspMode
    builder.uint8 @nldeMode
    builder.uint8 @nlmeMode
    builder.uint8 @apsdeMode
    builder.uint8 @afdeMode
    builder.uint8 @apsmeMode
    builder.uint8 @zdpMode

ZtcFrame.registerFrame ModeSelectRequest

module.exports = ModeSelectRequest