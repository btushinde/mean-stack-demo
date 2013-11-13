
# Module dependencies.
mongoose = require('mongoose')
async = require('async')
Article = mongoose.model('Article')
_ = require('underscore')


# Find article by id
exports.article = (req, res, next, id) ->
  Article.load id, (err, article) ->
    return next(err)  if err
    return next(new Error('Failed to load article ' + id))  unless article
    req.article = article
    next()



# Create a article
exports.create = (req, res) ->
  article = new Article(req.body)
  article.save (err) ->
    if err
      res.send 500, 'Something broke!'
    else
      res.jsonp article




# Update a article
exports.update = (req, res) ->
  article = req.article
  article = _.extend(article, req.body)
  article.save (err) ->
    res.jsonp article




# Delete an article
exports.destroy = (req, res) ->
  article = req.article
  article.remove (err) ->
    if err
      res.render 'error',
        status: 500

    else
      res.jsonp article




# Show an article
exports.show = (req, res) ->
  res.jsonp req.article



# List of Articles
exports.all = (req, res) ->
  Article.find().sort('-created').exec (err, articles) ->
    if err
      res.render 'error',
        status: 500

    else
      res.jsonp articles
