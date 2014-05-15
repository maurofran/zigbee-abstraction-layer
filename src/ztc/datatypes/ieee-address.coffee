###
  ieee-address.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

_ = require "lodash"

class IEEEAddress
  # The length, in bytes, of this data
  @LENGTH = 8

  @EMPTY_ADDRESS = new IEEEAddress "0000000000000000"

  # Creates a new IEEEAddress given the provided buffer content
  #
  # @param [Buffer] buffer the buffer used to initialize the IEEE address
  constructor: (@buffer) ->
    @buffer = new Buffer @buffer, "hex" if _.isString @buffer

  # Returns the representation of this IEEE address as buffer.
  #
  # @returns [Buffer]
  asBuffer: () ->
    @buffer

  toHex: () ->
    @buffer.toString "hex"

module.exports = IEEEAddress