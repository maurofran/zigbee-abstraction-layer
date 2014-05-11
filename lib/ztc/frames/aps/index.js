/*
 * index.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

module.exports = {
    ClearDeviceKeyPairSet: {
        Request: require("./cleardevicekeypairsetrequest"),
        Confirm: require("./cleardevicekeypairsetconfirm")
    },
    ConfirmID: {
        Report: require("./confirmidreport")
    },
    DataFragment: {
        Request: require("./datafragmentrequest"),
        Indication: require("./datafragmentindication")
    },
    DeregisterEndpoint: {
        Request: require("./deregisterendpointrequest"),
        Confirm: require("./deregisterendpointconfirm")
    }
};