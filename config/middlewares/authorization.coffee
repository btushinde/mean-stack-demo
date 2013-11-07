###
Generic require login routing middleware
###
exports.requiresLogin = (req, res, next) ->
  return res.send(401, "User is not authorized")  unless req.isAuthenticated()
  next()


###
User authorizations routing middleware
###
exports.user = hasAuthorization: (req, res, next) ->
  return res.send(401, "User is not authorized")  unless req.profile.id is req.user.id
  next()


###
Article authorizations routing middleware
###
exports.article = hasAuthorization: (req, res, next) ->
  return res.send(401, "User is not authorized")  unless req.article.user.id is req.user.id
  next()