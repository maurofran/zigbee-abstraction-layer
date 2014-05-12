###
  nv-get-page-headers-confirm.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class NVGetPageHeadersConfirm extends ZtcFrame
  @OPCODE_GROUP = 0xA4
  @OPCODE = 0xE6

  constructor: (parser) ->
    super NVGetPageHeadersConfirm.OPCODE_GROUP, NVGetPageHeadersConfirm.OPCODE
    parser.uint8 "status"
    parser.uint8 "numberOfPages"
    parser.tap () ->
      count = 0
      @loop "headers", (end) ->
        if count < @vars.numberOfPages
          @uint16le "magicNumber"
          @uint16le "sequenceNumber"
          @uint16le "dataSetId"
          count++
        else
          end true
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame NVGetPageHeadersConfirm

module.exports = NVGetPageHeadersConfirm