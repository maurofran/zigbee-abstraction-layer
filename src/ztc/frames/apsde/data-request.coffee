###
  data-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

   C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class DataRequest extends ZtcFrame
  @OPCODE_GROUP = 0x9C
  @OPCODE = 0x00
  
  constructor: (@dstAddrMode, @dstAddress, @dstEndpoint, @profileId, @clusterId, @srcEndpoint, @asdu, @txOptions,
                @radiusCounter) ->
    super DataRequest.OPCODE_GROUP, DataRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 18 + @asdu.length
    builder.uint8 @dstAddrMode
    builder.ieeeAddress @dstAddress
    builder.uint8 @dstEndpoint
    builder.uint16le @profileId
    builder.uint16le @clusterId
    builder.uint8 @srcEndpoint
    builder.uint8 @asdu.length
    builder.buffer @asdu
    builder.uint8 @txOptions
    builder.uint8 @radiusCounter

ZtcFrame.registerFrame DataRequest

module.exports = DataRequest