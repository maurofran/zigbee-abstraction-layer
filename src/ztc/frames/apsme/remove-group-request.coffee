###
  remove-group-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RemoveGroupRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xE9
  
  constructor: (@groupAddress, @endpoint) ->
    super RemoveGroupRequest.OPCODE_GROUP, RemoveGroupRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 3
    builder.shortAddress @groupAddress
    builder.uint8 @endpoint

ZtcFrame.registerFrame RemoveGroupRequest

module.exports = RemoveGroupRequest