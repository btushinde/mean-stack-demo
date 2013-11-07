###
Module dependencies.
###
mongoose = require("mongoose")
Schema = mongoose.Schema
crypto = require("crypto")
_ = require("underscore")
authTypes = ["github", "twitter", "facebook", "google"]

###
User Schema
###
UserSchema = new Schema(
  name: String
  email: String
  username:
    type: String
    unique: true

  provider: String
  hashed_password: String
  salt: String
  facebook: {}
  twitter: {}
  github: {}
  google: {}
)

###
Virtuals
###
UserSchema.virtual("password").set((password) ->
  @_password = password
  @salt = @makeSalt()
  @hashed_password = @encryptPassword(password)
).get ->
  @_password


###
Validations
###
validatePresenceOf = (value) ->
  value and value.length


# the below 4 validations only apply if you are signing up traditionally
UserSchema.path("name").validate ((name) ->

  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  name.length
), "Name cannot be blank"
UserSchema.path("email").validate ((email) ->

  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  email.length
), "Email cannot be blank"
UserSchema.path("username").validate ((username) ->

  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  username.length
), "Username cannot be blank"
UserSchema.path("hashed_password").validate ((hashed_password) ->

  # if you are authenticating by any of the oauth strategies, don't validate
  return true  if authTypes.indexOf(@provider) isnt -1
  hashed_password.length
), "Password cannot be blank"

###
Pre-save hook
###
UserSchema.pre "save", (next) ->
  return next()  unless @isNew
  if not validatePresenceOf(@password) and authTypes.indexOf(@provider) is -1
    next new Error("Invalid password")
  else
    next()


###
Methods
###
UserSchema.methods =

  ###
  Authenticate - check if the passwords are the same

  @param {String} plainText
  @return {Boolean}
  @api public
  ###
  authenticate: (plainText) ->
    @encryptPassword(plainText) is @hashed_password


  ###
  Make salt

  @return {String}
  @api public
  ###
  makeSalt: ->
    Math.round((new Date().valueOf() * Math.random())) + ""


  ###
  Encrypt password

  @param {String} password
  @return {String}
  @api public
  ###
  encryptPassword: (password) ->
    return ""  unless password
    crypto.createHmac("sha1", @salt).update(password).digest "hex"

mongoose.model "User", UserSchema