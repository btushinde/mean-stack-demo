# Module dependencies.
mongoose = require("mongoose")
User = mongoose.model("User")



# Auth callback
exports.authCallback = (req, res, next) ->
  res.redirect "/"


# Show login form
exports.signin = (req, res) ->
  res.render "users/signin",
    title: "Signin"
    message: req.flash("error")



# Show sign up form
exports.signup = (req, res) ->
  res.render "users/signup",
    title: "Sign up"
    user: new User()



# Logout
exports.signout = (req, res) ->
  req.logout()
  res.redirect "/"


# Session
exports.session = (req, res) ->
  res.redirect "/"


# Create user
exports.create = (req, res) ->
  user = new User(req.body)
  user.provider = "local"
  user.save (err) ->
    if err
      return res.render("users/signup",
        errors: err.errors
        user: user
      )
    req.logIn user, (err) ->
      return next(err)  if err
      res.redirect "/"


# Show profile
exports.show = (req, res) ->
  user = req.profile
  res.render "users/show",
    title: user.name
    user: user


# Send User
exports.me = (req, res) ->
  res.jsonp req.user or null


# Find user by id
exports.user = (req, res, next, id) ->
  User.findOne(_id: id).exec (err, user) ->
    return next(err)  if err
    return next(new Error("Failed to load User " + id))  unless user
    req.profile = user
    next()
