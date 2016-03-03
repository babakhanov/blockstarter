var Colu = require('colu')
var jf = require('jsonfile')
var express = require('express')
var bodyParser = require('body-parser')
var dbFileName = 'db.json'

var db = jf.readFileSync(__dirname + '/' + dbFileName)
var app = express()

var colu = new Colu({
  network: 'mainnet',
  privateSeedWIF: 'KxjT1Q2H6MqheA6xnwKB9QJGddTAUD6KMtNpuvqvcnxpszG1mJKn',
  apiKey: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJiYWJha2hhbm92MUBnbWFpbC5jb20iLCJleHAiOiIyMDE2LTA0LTA5VDAxOjA0OjA2LjgwOVoiLCJ0eXBlIjoiYXBpX2tleSJ9.2fJ8fsJ4UgaqFn9aW9b2kUxd-F1NVB0IhZFImoedDCk'
})

app.use(bodyParser.json())

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.get('/getTickets', function (req, res, next) {
  return res.send(db)
})

app.post('/buyTicket', function (req, res, next) {
  var ticketName = req.body.ticketName
  var assetId = db[ticketName].assetId
  var address = req.body.address
  var fromAddress = db[ticketName].address

  var settings = {
    'from': [fromAddress],
    'to': [{
      'address': address,
      'assetId': assetId,
      'amount': 1
    }]
  }
  colu.sendAsset(settings, function (err, result) {
    if (err) return next(err)
    db[ticketName].amount -= 1
    jf.writeFile(__dirname + '/' + dbFileName, db, function (err) {
      if (err) return next(err)
      res.send('success', result)
    })
  })
})

app.post('/addTickets', function (req, res, next) {
  var ticketName = req.body.ticketName
  var amount = req.body.amount
  var settings = {
    metadata: {
     'assetName': ticketName
    },
    'amount': amount
  }
  colu.issueAsset(settings, function (err, result) {
    if (err) return err
    db[ticketName] = {
      amount: result.receivingAddresses[0].amount,
      assetId: result.assetId,
      address: result.receivingAddresses[0].address
    }
    jf.writeFile(__dirname + '/' + dbFileName, db, function (err) {
      if (err) return next(err)
      res.send('tickets', db)
    })
  })
})

colu.on('connect', function () {
  app.listen(8080, function () {
    console.log('server started')
  })
})

colu.init()
