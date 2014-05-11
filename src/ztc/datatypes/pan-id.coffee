###
  pan-id.coffee
  https://github.com/maurofranceschini/zigbee-abstraction-layer

  (C) 2014-2014 Mauro Franceschini
  Release under Apache 2 License.
###

class PANId
  @LENGTH = 8

  # Creates a new PANId.
  #
  # @param [Buffer] buffer the buffer
  constructor: (@buffer) ->

  asBuffer: () ->
    @buffer

module.exports = PANId