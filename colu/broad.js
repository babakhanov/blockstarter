// broadcast.js
var bitcoin = require('bitcoinjs-lib');
var request = require('request');
function postToApi(api_endpoint, json_data, callback) {
    console.log(api_endpoint+': ', JSON.stringify(json_data));
    request.post({
        url: 'http://testnet.api.coloredcoins.org:80/v3/'+api_endpoint,
        headers: {'Content-Type': 'application/json'},
        form: json_data
    }, 
    function (error, response, body) {
        if (error) {
            return callback(error);
        }
        if (typeof body === 'string') {
            body = JSON.parse(body)
        }
        console.log('Status: ', response.statusCode);
        console.log('Body: ', JSON.stringify(body));
        return callback(null, body);
    });
};

var signedTxHex= '0100000001c7967cb3ec3adaa15dde14a1e855eb5d9050b84afcd7cd5e55506543e5acc680000000009000483045022100e3739ca56fcb33f7746945ba0bf116d629121005374dad0cfd98a275a834d8190220062baf67eec4ad91dd0945623a9648b261a951bb3dd00dd9f565be4e7337c87f0145514104ae9455b50285ede54ba40a74328b4fdaafb081b3126ac53c5632cda00e506361a02656b8466144369e489e7f7cc72d7b4eee32d9c3098d4719806433a1a3b37b51aeffffffff03ac0200000000000047512103ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff21033cecc239c5309ae6b538daa052c0c819542dd7deff7330fc87fb2e03c9d924d552ae00000000000000001d6a1b4343020279894200d2c5c46e676e2ec85294718421268118205110bcbc0000000000001976a914f31165aecc3d71af7929851a60dacfec770dbba588ac00000000';
var transaction = {
    'txHex': signedTxHex
}

postToApi('broadcast', transaction, function(err, body){
    if (err) {
        console.log('error: ', err);
    }
    console.log(body);
});
