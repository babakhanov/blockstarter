var bitcoin = require('bitcoinjs-lib');
function signTx (unsignedTx, wif) {
    var privateKey = bitcoin.ECKey.fromWIF(wif)
    var tx = bitcoin.Transaction.fromHex(unsignedTx)
    var insLength = tx.ins.length
    console.log(tx);
    for (var i = 0; i < insLength; i++) {
        tx.sign(i, privateKey)
    }
    return tx.toHex()
}
var key = 'cTS3nauom9j5jpwAxZ1MMVGBcFxWqZPcKZDRE34ZNhTxJ4q3K8xd';
var txHex = '01000000013955ebb1a92004272f85d3473f5d7565c17ef4cd06477a263054bb28d581266a0300000000ffffffff04ac0200000000000047512103ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff2103d0034e5a7882221c448ad1603cf75a5960feaf2ce19c9eaa0020ef9407061ab152ae58020000000000001976a9149614189d023de75198e221ec50d80cea99ffec0f88ac00000000000000001e6a1c4343020249dd63539897255e1497f6ab0c0cf86dd12c4f9619011910c4750000000000001976a9149614189d023de75198e221ec50d80cea99ffec0f88ac00000000';
var signedTxHex = signTx(txHex, key);

console.log(signedTxHex);

