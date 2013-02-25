var dw = require('DirWatcher');
var exec = require('child_process').exec;

dw.watchDir('./docs', function (){
    console.log( 'change!' );
    exec( 'make' );
});
