###
  process-secure-frame-report.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ProcessSecureFrameReport extends ZtcFrame
  @OPCODE_GROUP = 0x98
  @OPCODE = 0xCC

  @Status =
    SUCCESS: 0x00
    SECURITY_FAIL: 0xA2
    SECURITY_OFF: 0x06

  constructor: (parser) ->
    super ProcessSecureFrameReport.OPCODE_GROUP, ProcessSecureFrameReport.OPCODE
    parser.uint8 "status"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ProcessSecureFrameReport

module.exports = ProcessSecureFrameReport