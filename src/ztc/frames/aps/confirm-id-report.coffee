###
  confirm-id-report.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

ZtcFrame = require "../../ztc-frame"
_ = require "lodash"

class ConfirmIdReport extends ZtcFrame
  @OPCODE_GROUP = 0x9D
  @OPCODE = 0x03

  constructor: (parser) ->
    super ConfirmIdReport.OPCODE_GROUP, ConfirmIdReport.OPCODE
    parser.uint8 "assignedConfirmId"
    parser.tap () => _.assign this, parser.vars

ZtcFrame.registerFrame ConfirmIdReport

module.exports = ConfirmIdReport