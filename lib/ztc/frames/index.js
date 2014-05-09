/*
 * index.js
 * https://github.com/maurofranceschini/zigbee-abstraction-layer
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

module.exports = {
    ReadSAS: require("./readsas"),
    ReadSASConfirm: require("./readsasconfirm"),
    WriteSAS: require("./writesas"),
    SaveConfirm: require("./saveconfirm"),
    CPUReset: require("./cpureset"),

    GetChannel: {
        Request: require("./getchannelrequest"),
        Confirm: require("./getchannelconfirm")
    },
    GetMode: {
        Request: require("./getmoderequest"),
        Confirm: require("./getmodeconfirm")
    },
    GetNumOfMsgs: {
        Request: require("./getnumofmsgsrequest"),
        Confirm: require("./getnumofmsgsconfirm")
    },
    GetPanID: {
        Request: require("./getpanidrequest"),
        Confirm: require("./getpanidconfirm")
    }
};