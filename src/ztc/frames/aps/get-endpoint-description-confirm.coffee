###
  get-endpoint-description-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetEndpointDescriptionConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x0D

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super GetEndpointDescriptionConfirm.OPCODE_GROUP, GetEndpointDescriptionConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "endpoint"
    parser.uint16le "applicationProfileId"
    parser.uint16le "applicationDeviceId"
    parser.uint8 "applicationDeviceAndVersionFlags"
    parser.uint8 "applicationNumberInClusters"
    parser.tap () ->
      counter = 0
      @loop "inClusters", (end) ->
        if counter < @vars.applicationNumberInClusters
          @uint16le "clusterId"
          counter++
        else
          end true
      @tap () ->
        delete @vars.applicationNumberInClusters
        @vars.inClusters = _.map @vars.inClusters, "clusterId"
    parser.uint8 "applicationNumberOutClusters"
    parser.tap () ->
      counter = 0
      @loop "outClusters", (end) ->
        if counter < @vars.applicationNumberOutClusters
          @uint16le "clusterId"
          counter++
        else
          end true
      @tap () ->
        delete @vars.applicationNumberOutClusters
        @vars.outClusters = _.map @vars.outClusters, "clusterId"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetEndpointDescriptionConfirm

module.exports = GetEndpointDescriptionConfirm