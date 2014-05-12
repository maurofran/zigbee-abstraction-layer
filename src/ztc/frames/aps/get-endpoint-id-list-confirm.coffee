###
  get-endpoint-id-list-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class GetEndpointIdListConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0x0E

  @Status =
    SUCCESS: 0x00

  constructor: (parser) ->
    super GetEndpointIdListConfirm.OPCODE_GROUP, GetEndpointIdListConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "listLength"
    parser.tap () ->
      counter = 0
      @loop "endpointList", (end) ->
        if counter < @vars.listLength
          @uint8 "endpoint"
          counter++
        else
          end true
      @tap () ->
        delete @vars.listLength
        @vars.endpointList = _.map @vars.endpointList, "endpoint"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame GetEndpointIdListConfirm

module.exports = GetEndpointIdListConfirm