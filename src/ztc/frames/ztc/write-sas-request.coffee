###
  write-sas-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class WriteSASRequest extends ZtcFrame
  @OPCODE_GROUP = 0x50
  @OPCODE = 0x01
  
  constructor: (@shortAddress, @extendedPanId, @apsUseExtendedPanId, @panId, @channelsMask, @protocolVersion,
                @stackProfile, @startupControl, @trustCenterAddress, @trustCenterMasterKey, @networkKey,
                @useInsecureJoin, @preconfiguredTrustCenterLinkKey, @activeNetworkKeySequenceNumber, @networkKeyType,
                @networkManagerAddress, @scanAttempts, @timeBetweenScans, @rejoinInterval, @maximumRejoinInterval,
                @indirectPollRate, @parentLinkRetryThresold, @isConcentrator, @concentratorRadius,
                @concentratorDiscoveryTime) ->
    super WriteSASRequest.OPCODE_GROUP, WriteSASRequest.OPCODE

  _writePayload: (builder) ->
    builder.uint8 101
    builder.shortAddress @shortAddress
    builder.panId @extendedPanId
    builder.panId @apsUseExtendedPanId
    builder.uint16le @panId
    builder.uint32le @channelsMask
    builder.uint8 @protocolVersion
    builder.uint8 @stackProfile
    builder.uint8 @startupControl
    builder.ieeeAddress @trustCenterAddress
    builder.key @trustCenterMasterKey
    builder.key @networkKey
    builder.uint8 @useInsecureJoin
    builder.key @preconfiguredTrustCenterLinkKey
    builder.uint8 @activeNetworkKeySequenceNumber
    builder.uint8 @networkKeyType
    builder.shortAddress @networkManagerAddress
    builder.uint8 @scanAttempts
    builder.uint16le @timeBetweenScans
    builder.uint16le @rejoinInterval
    builder.uint16le @maximumRejoinInterval
    builder.uint16le @indirectPollRate
    builder.uint8 @isConcentrator
    builder.uint8 @concentratorRadius
    builder.uint8 @concentratorDiscoveryTime

ZtcFrame.registerFrame WriteSASRequest

module.exports = WriteSASRequest