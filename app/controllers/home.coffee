express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
nodemailer = require "nodemailer"
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

router.post '/contact', (req, res, next) ->

  expediteur = req.body.mail.email
  sujet = '[Mezouilhac] '+req.body.mail.prenom+" "+req.body.mail.nom+' vous a posé une question'
  message = req.body.mail.message

  transporter = nodemailer.createTransport(
    service: "gmail"
    auth:
      user: "martin.choraine@gmail.com"
      pass: "azerty@123"
  )
  transporter.sendMail
    from: expediteur
    to: 'martin.choraine@hotmail.fr'
    subject: sujet
    text: message
  , (err, info)->
      if err
        res.send false
      else
        res.send true
