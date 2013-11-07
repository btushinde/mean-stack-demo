
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

  user:
    type: Schema.ObjectId
    ref: 'User'
)


# Validations
ArticleSchema.path('title').validate ((title) ->
  title.length
), 'Title cannot be blank'



# Statics
ArticleSchema.statics = load: (id, cb) ->
  @findOne(_id: id).populate('user', 'name username').exec cb

mongoose.model 'Article', ArticleSchema