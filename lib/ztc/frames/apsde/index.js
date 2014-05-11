/*
 * index.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

module.exports = {
    Data: {
        Request: require("./datarequest"),
        Confirm: require("./dataconfirm"),
        Indication: require("./dataindication")
    }
};