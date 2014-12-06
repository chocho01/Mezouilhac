express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Chalet  = mongoose.model 'Chalet'

module.exports = (app) ->
	app.use '/', router

	router.get '/les-chalets', (req, res, next) ->
		Chalet.find (err, chalets) ->
			return next(err) if err
			res.render 'chalets',
			title: 'Les chalets'
			chalets: chalets
			pageName: 'chalets'

	# L'API pour retourner tous les activités
	router.get '/api/chalets', (req, res, next) ->
		Chalet.find (err, chalets) ->
			return next(err) if err
			res.send chalets

	# L'API pour retourner l'activité avec id = :id
	router.get '/api/chalets/:id', (req, res, next) ->
		Chalet.findById req.params.id, (err, chalet) ->
			return next(err) if err
			res.send chalet

