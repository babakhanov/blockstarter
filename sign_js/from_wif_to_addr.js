var bitcoin = require('bitcoinjs-lib');

var sanitize = function(val){
  return val.replace(/\s+/, '');
};

var fromWifToAddr = function(fromWif, toAddr, txBalance, amount, fee, txId, index) {
  var _key = bitcoin.ECKey.fromWIF(fromWif);
  var key = {addr: _key.pub.getAddress(bitcoin.networks.testnet).toString(), wif: fromWif };
  var tx = new bitcoin.TransactionBuilder();
  tx.addInput(txId, index);
  tx.addOutput(toAddr, amount);
  tx.addOutput(key.addr, txBalance - amount - fee);
  tx.sign(0, _key);
  return tx.build().toHex();
};
var fromWif = sanitize(process.argv[2]);
var toAddr = sanitize(process.argv[3]);
var txBalance = parseInt(sanitize(process.argv[4]));
var amount = parseInt(sanitize(process.argv[5]));
var fee = parseInt(sanitize(process.argv[6]));
var txId = sanitize(process.argv[7]);
var index = parseInt(sanitize(process.argv[8]));

console.log(fromWifToAddr(fromWif, toAddr, txBalance, amount, fee, txId, index));

