###
  short-address.coffee
  https://github.com/maurofranceschini/zal

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

_ = require "lodash"

class ShortAddress
  @LENGTH = 2

  # Creates a new ShortAddress.
  #
  # @param [Buffer] buffer the buffer
  constructor: (@buffer) ->
    @buffer = new Buffer @buffer, "hex" if _.isString @buffer

  asBuffer: () ->
    @buffer

  toHexString: () ->
    @buffer.toString "hex"

module.exports = ShortAddress