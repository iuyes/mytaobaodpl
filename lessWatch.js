var dw = require( 'DirWatcher' );
var exec = require( 'child_process').exec;

dw.watchDir( './less', function (){

    console.log( 'change!' );
    exec( 'make buildbs' );
});