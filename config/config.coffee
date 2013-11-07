_ = require("underscore")

# Load app configuration
module.exports = _.extend(
  require(__dirname + "/../config/env/all")
  require(__dirname + "/../config/env/" + process.env.NODE_ENV + ".json") or {}
)