###
  remove-all-groups-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RemoveAllGroupsRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0xEA
  
  constructor: (@endpoint) ->
    super RemoveAllGroupsRequest.OPCODE_GROUP, RemoveAllGroupsRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 1
    builder.uint8 @endpoint

ZtcFrame.registerFrame RemoveAllGroupsRequest

module.exports = RemoveAllGroupsRequest