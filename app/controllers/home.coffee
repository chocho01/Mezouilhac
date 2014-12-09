express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Chalet  = mongoose.model 'Chalet'

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->
  Chalet.find (err, chalets) ->
    return next(err) if err
    res.render 'index',
      title: 'Mezouilhac | Locations'
      pageName: 'accueil'
      chalets: chalets

router.get '/contact', (req, res, next) ->
    res.render 'contact',
      title: 'Mezouilhac | Contactez-nous'
      pageName: 'contact'