###
  short-address.coffee
  https://github.com/maurofranceschini/zal

  (C) 2014-2014 Mauro Franceschini
  Released under Apache 2 License.
###

class ShortAddress
  @LENGTH = 2

  # Creates a new ShortAddress.
  #
  # @param [Buffer] buffer the buffer
  constructor: (@buffer) ->

  asBuffer: () ->
    @buffer

module.exports = ShortAddress