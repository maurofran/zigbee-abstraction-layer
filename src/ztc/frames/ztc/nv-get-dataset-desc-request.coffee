###
  nv-get-dataset-desc-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class NVGetDataSetDescRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xE5

  constructor: () ->
    super NVGetDataSetDescRequest.OPCODE_GROUP, NVGetDataSetDescRequest.OPCODE

ZtcFrame.registerFrame NVGetDataSetDescRequest

module.exports = NVGetDataSetDescRequest