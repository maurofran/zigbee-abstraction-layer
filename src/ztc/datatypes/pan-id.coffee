###
  pan-id.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Release under Apache 2 License.
###

_ = require "lodash"

class PANId
  @LENGTH = 2

  # Creates a new PANId.
  #
  # @param [Buffer] buffer the buffer
  constructor: (@buffer) ->
    @buffer = new Buffer @buffer, "hex" if _.isString @buffer

  asBuffer: () ->
    @buffer

  toHexString: () ->
    @buffer.toString "hex"

module.exports = PANId