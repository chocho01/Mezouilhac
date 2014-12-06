express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Activite  = mongoose.model 'Activite'

module.exports = (app) ->
	app.use '/', router

	# La page des activités
	router.get '/activites', (req, res, next) ->
		res.render 'activites',
			title: 'Les activités / région'
			pageName: 'activites'

	# L'API pour retourner tous les activités
	router.get '/api/activites', (req, res, next) ->
		Activite.find (err, activites) ->
			return next(err) if err
			res.send activites

	# L'API pour retourner l'activité avec id = :id
	router.get '/api/activites/:id', (req, res, next) ->
		Activite.findById req.params.id, (err, activite) ->
			return next(err) if err
			res.send activite

