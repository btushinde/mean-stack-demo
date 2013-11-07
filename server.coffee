###
Module dependencies.
###
express = require("express")
fs = require("fs")
passport = require("passport")
logger = require("mean-logger")
stylus = require("stylus")

###
Main application entry file.
Please note that the order of loading is important.
###

#Load configurations
#if test env, load example file
env = process.env.NODE_ENV = process.env.NODE_ENV or "development"
config = require("./config/config")
auth = require("./config/middlewares/authorization")
mongoose = require("mongoose")

#Bootstrap db connection
db = mongoose.connect(config.db)

#Bootstrap models
models_path = __dirname + "/app/models"
walk = (path) ->
  fs.readdirSync(path).forEach (file) ->
    newPath = path + "/" + file
    stat = fs.statSync(newPath)
    if stat.isFile()
      require newPath  if /(.*)\.(js|coffee)/.test(file)
    else walk newPath  if stat.isDirectory()


walk models_path

#bootstrap passport config
require("./config/passport") passport
app = express()

#express settings
require("./config/express") app, passport, db

#Bootstrap routes
require("./config/routes") app, passport, auth

#Start the app by listening on <port>
port = process.env.PORT or config.port
app.listen port
console.log "Express app started on port " + port

#Initializing logger
logger.init app, passport, mongoose

#expose app
exports = module.exports = app