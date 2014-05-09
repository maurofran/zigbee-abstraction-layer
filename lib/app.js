/*
 * ztcmessage.json
 * https://github.com/maurofranceschini/zal
 *
 * (C) 2014-2014 Mauro Franceschini
 * Release under Apache 2 License.
 */
"use strict";

var SerialPort = require("serialport").SerialPort,
    ZtcReader = require("./ztc").ZtcReader,
    ZtcWriter = require("./ztc").ZtcWriter,
    ZtcFrame = require("./ztc").ZtcFrame,
    ReadSAS = require("./ztc/payloads/readsas"),
    ReadSASConfirm = require("./ztc/payloads/readsasconfirm"),
    DEVICE = "/dev/cu.usbserial-A5014HH3",
    serialPort = new SerialPort(DEVICE, {
        baudrate: 115200
    });

serialPort.on("open", function () {
    var reader = new ZtcReader(serialPort),
        writer = new ZtcWriter(serialPort);

    reader.on("frame", function (frame) {
        var confirm = new ReadSASConfirm(frame.contentAsBuffer());
        console.log(confirm);
        process.exit();
    });

    var payload = new ReadSAS(ReadSAS.Source.RAM),
        frame = ZtcFrame.fromPayload(payload);

    writer.writeFrame(frame);
});