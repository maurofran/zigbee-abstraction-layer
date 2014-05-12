###
  nv-get-page-headers-request.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"

class NVGetPageHeadersRequest extends ZtcFrame
  @OPCODE_GROUP = 0xA3
  @OPCODE = 0xE6

  constructor: () ->
    super NVGetPageHeadersRequest.OPCODE_GROUP, NVGetPageHeadersRequest.OPCODE

ZtcFrame.registerFrame NVGetPageHeadersRequest

module.exports = NVGetPageHeadersRequest