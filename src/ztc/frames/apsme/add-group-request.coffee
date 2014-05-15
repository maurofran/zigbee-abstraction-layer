###
  add-group-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class AddGroupRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xE8
  
  constructor: (@groupAddress, @endpoint) ->
    super AddGroupRequest.OPCODE_GROUP, AddGroupRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 3
    builder.shortAddress @groupAddress
    builder.uint8 @endpoint

ZtcFrame.registerFrame AddGroupRequest

module.exports = AddGroupRequest