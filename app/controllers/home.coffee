express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->
    res.render 'index',
      title: 'Mezouilhac | Locations'
      pageName: 'accueil'

router.get '/contact', (req, res, next) ->
    res.render 'contact',
      title: 'Mezouilhac | Contactez-nous'
      pageName: 'contact'