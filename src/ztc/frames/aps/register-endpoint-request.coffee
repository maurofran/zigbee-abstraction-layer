###
  register-endpoint-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class RegisterEndpointRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0x0B

  constructor: (@endpoint, @applicationProfileId, @applicationDeviceId, @deviceAndVersionFlags, @inputClusters,
                @outputClusters, @maxWindowSize) ->
    super RegisterEndpointRequest.OPCODE_GROUP, RegisterEndpointRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 9 + 2 * @inputClusters.length + 2 * @outputClusters.length
    builder.uint8 @endpoint
    builder.uint16le @applicationProfileId
    builder.uint16le @applicationDeviceId
    builder.uint8 @deviceAndVersionFlags
    builder.uint8 @inputClusters.length
    builder.uint16le cluster for cluster in @inputClusters
    builder.uint8 @outputClusters.length
    builder.uint16le cluster for cluster in @outputClusters
    builder.uint8 @maxWindowSize

ZtcFrame.registerFrame RegisterEndpointRequest

module.exports = RegisterEndpointRequest