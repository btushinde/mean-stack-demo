###
Module dependencies.
###
express = require('express')
mongoStore = require('connect-mongo')(express)
flash = require('connect-flash')
helpers = require('view-helpers')
config = require('./config')


module.exports = (app, db) ->
  app.set 'showStackError', true

  #Prettify HTML
  app.locals.pretty = true

  #Should be placed before express.static
  app.use express.compress(
    filter: (req, res) ->
      (/json|text|javascript|css/).test res.getHeader('Content-Type')

    level: 9
  )

  #Setting the fav icon and static folder
  app.use express.favicon()
  app.use express.static(config.root + '/public')

  #Don't use logger for test env
  app.use express.logger('dev')  if process.env.NODE_ENV isnt 'test'

  #Set views path, template engine and default layout
  app.set 'views', config.root + '/views'
  app.set 'view engine', 'jade'

  #Enable jsonp
  app.enable 'jsonp callback'
  app.configure ->

    #cookieParser should be above session
    app.use express.cookieParser()

    #bodyParser should be above methodOverride
    app.use express.bodyParser()
    app.use express.methodOverride()

    #express/mongo session storage
    app.use express.session(
      secret: 'MEAN'
      store: new mongoStore(
        db: db.connection.db
        collection: 'sessions'
      )
    )

    #connect flash for flash messages
    app.use flash()

    #dynamic helpers
    app.use helpers(config.app.name)

    #routes should be at the last
    app.use app.router

    #Assume 'not found' in the error msgs is a 404. this is somewhat silly, but valid, you can do whatever you like, set properties, use instanceof etc.
    app.use (err, req, res, next) ->

      #Treat as 404
      return next()  if ~err.message.indexOf('not found')

      #Log it
      console.error err.stack

      #Error page
      res.status(500).render '500',
        error: err.stack


    #Assume 404 since no middleware responded
    app.use (req, res, next) ->
      res.status(404).render '404',
        url: req.originalUrl
        error: 'Not found'


