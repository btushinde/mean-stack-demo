###
Module dependencies.
###
mongoose = require("mongoose")
async = require("async")
_ = require("underscore")
exports.render = (req, res) ->
  res.render "index",
    user: (if req.user then JSON.stringify(req.user) else "null")
