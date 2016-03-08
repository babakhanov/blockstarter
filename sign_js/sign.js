var bitcoin = require('bitcoinjs-lib');

function signTx (unsignedTx, wif) {
    var privateKey = bitcoin.ECKey.fromWIF(wif)
    var tx = bitcoin.Transaction.fromHex(unsignedTx)
    var insLength = tx.ins.length
    for (var i = 0; i < insLength; i++) {
        tx.sign(i, privateKey)
    }
    return tx.toHex();
}
var txHex = process.argv[2].replace(/\s+/g, '');
var wif = process.argv[3].replace(/\s+/g, '');
var signedTx = signTx(txHex, wif);

console.log(signedTx);

