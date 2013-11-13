
# Module dependencies.
mongoose = require('mongoose')
config = require('../../config/config')
Schema = mongoose.Schema


# Article Schema
ArticleSchema = new Schema(
  created:
    type: Date
    default: Date.now

  title:
    type: String
    default: ''
    trim: true

  content:
    type: String
    default: ''
    trim: true
)


# Validations
ArticleSchema.path('title').validate ((title) ->
  title.length
), 'Title cannot be blank'


mongoose.model 'Article', ArticleSchema