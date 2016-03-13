var bitcoin = require('bitcoinjs-lib');

var sanitize = function(val) {
  return val.replace(/^\s+/, '').replace(/\s+$/, '');
};

var from_wif_to_addr = function(fromWif, toAddr, balance, amount, fee, txId, index) {

  var _key = bitcoin.ECKey.fromWIF(fromWif);
  var key = { "addr": _key.pub.getAddress(bitcoin.networks.testnet).toString(), "wif": fromWif };
  var tx = new bitcoin.TransactionBuilder();

  tx.addInput(txId, index);
  tx.addOutput(toAddr, amount);
  tx.addOutput(key.addr, balance - amount - fee);
  tx.sign(0, key);
  var txHex = tx.build().toHex();
  console.log(txHex);
};

//var fromWif = sanitize(process.argv[2]);
//var toAddr = sanitize(process.argv[3]);
//var balance = sanitize(process.argv[4]);
//var amount = sanitize(process.argv[5]);
//var fee = sanitize(process.argv[6]);
//var txId = sanitize(process.argv[7]);
//var index = sanitize(process.argv[8]);

var t = {
  fromWif: 'cTS3nauom9j5jpwAxZ1MMVGBcFxWqZPcKZDRE34ZNhTxJ4q3K8xd',
  toAddr: 'mvd6dELHPtceGJHKMf24uWNy6NoARsnyWd',
  balance: 974399,
  amount: 5000,
  fee: 5000,
  txId: '2b94ad76f30cdddcc32f104ec693ce14203813523eccb309a6056f83b3c88c90',
  index: 0
};

from_wif_to_addr(t.fromWif, t.toAddr, t.balance, t.amount, t.fee, t.txId, t.index);
