module.exports = function (grunt) {
    "use strict";

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),
        mochaTest: {
            options: {
                reporter: "spec"
            },
            src: ["test/**/*-spec.js"]
        },
        jshint: {
            options: {
                strict: true,
                camelcase: true,
                bitwise: true,
                curly: true,
                indent: 4,
                latedef: true,
                newcap: true,
                quotmark: "double",
                undef: true,
                unused: true,
                maxlen: 120,
                node: true
            },
            all: ["Gruntfile.js", "app/**/*.js", "test/**/*.js"]
        }
    });

    grunt.loadNpmTasks("grunt-mocha-test");
    grunt.loadNpmTasks("grunt-contrib-jshint");

    grunt.registerTask("default", ["jshint", "mochaTest"]);
};