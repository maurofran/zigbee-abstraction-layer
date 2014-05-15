###
  reset-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class ResetRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0x0B

  @ResetType =
    RESET_ALL: 0x1F
    RESET_SIMPLE: 0x01
    RESET_BOUNDS: 0x02
    RESET_ADDR_MAP: 0x04
    RESET_COM_SEC: 0x08
    RESET_GROUPS: 0x10
  
  constructor: (@resetType) ->
    super ResetRequest.OPCODE_GROUP, ResetRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @resetType

ZtcFrame.registerFrame ResetRequest

module.exports = ResetRequest