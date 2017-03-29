var express = require('express');
var router = express.Router();

var counter = 0;

router.get('/', function(req, res, next) {
  counter++;
  res.send({"counter" : counter});
});

router.put('/:value', function(req, res, next) {
    counter = req.params.value;
  res.send({"counter" : counter});
});

module.exports = router;
