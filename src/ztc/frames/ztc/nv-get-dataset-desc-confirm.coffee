###
  nv-get-dataset-desc-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class NVGetDataSetDescConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xE5

  constructor: (parser) ->
    super NVGetDataSetDescConfirm.OPCODE_GROUP, NVGetDataSetDescConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "count"
    parser.tap () ->
      count = 0
      @loop "datasets", (end) ->
        if count < @vars.count
          @uint8 "size"
          @uint16le "id"
          count++
        else
          end true
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame NVGetDataSetDescConfirm

module.exports = NVGetDataSetDescConfirm