###
  unbind-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class UnbindRequest extends ZtcFrame
  @OPCODE_GROUP = 0x99
  @OPCODE = 0x09
  
  constructor: (@srcAddress, @srcEndpoint, @clusterId, @dstAddrMode, @dstAddress, @dstEndpoint) ->
    super UnbindRequest.OPCODE_GROUP, UnbindRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 21
    builder.ieeeAddress @srcAddress
    builder.uint8 @srcEndpoint
    builder.uint16le @clusterId
    builder.uint8 @dstAddrMode
    builder.ieeeAddress @dstAddress
    builder.uint8 @dstEndpoint

ZtcFrame.registerFrame UnbindRequest

module.exports = UnbindRequest