###
  get-max-application-payload-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class GetMaxApplicationPayloadRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x27

  constructor: (@dstAddrMode, @dstAddr, @dstEndpoint, @profileId, @clusterId, @srcEndpoint,
                @asduLength, @asduPointer, @txOptions, @radiusCounter) ->
    super GetMaxApplicationPayloadRequest.OPCODE_GROUP, GetMaxApplicationPayloadRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 20
    builder.uint8 @dstAddrMode
    builder.ieeeAddress @dstAddr
    builder.uint8 @dstEndpoint
    builder.uint16le @profileId
    builder.uint16le @clusterId
    builder.uint8 @srcEndpoint
    builder.uint8 @asduLength
    builder.uint16le @asduPointer
    builder.uint8 @txOptions
    builder.uint8 @radiusCounter

ZtcFrame.registerFrame GetMaxApplicationPayloadRequest

module.exports = GetMaxApplicationPayloadRequest