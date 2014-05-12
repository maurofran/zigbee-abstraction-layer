###
  read-sas-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ReadSASConfirm extends ZtcFrame
  @OPCODE_GROUP = 0x50
  @OPCODE = 0x03

  constructor: (parser) ->
    super ReadSASConfirm.OPCODE_GROUP, ReadSASConfirm.OPCODE
    parser.shortAddress "shortAddress"
    parser.panId "extendedPanId"
    parser.panId "apsUseExtendedPanId"
    parser.uint16le "panId"
    parser.uint32le "channelsMask"
    parser.uint8 "protocolVersion"
    parser.uint8 "stackProfile"
    parser.uint8 "startupControl"
    parser.ieeeAddress "trustCenterAddress"
    parser.key "trustCenterMasterKey"
    parser.key "networkKey"
    parser.uint8 "useInsecureJoin" 
    parser.key "preconfiguredTrustCenterLinkKey" 
    parser.uint8 "activeNwkKeySeqNumber" 
    parser.uint8 "networkKeyType" 
    parser.shortAddress "networkManagerAddress" 
    parser.uint8 "scanAttempts" 
    parser.uint16le "timeBetweenScans" 
    parser.uint16le "rejoinInterval" 
    parser.uint16le "maximumRejoinInterval" 
    parser.uint16le "indirectPollRate" 
    parser.uint8 "parentLinkRetryThreshold" 
    parser.uint8 "isConcentrator" 
    parser.uint8 "concentratorRadius" 
    parser.uint8 "concentratorDiscoveryTime"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ReadSASConfirm

module.exports = ReadSASConfirm