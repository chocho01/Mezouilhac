express  = require 'express'
router = express.Router()
passport = require 'passport'
mongoose = require 'mongoose'
Activite  = mongoose.model 'Activite'

module.exports = (app) ->
	app.use '/admin', router

	router.get '/', (req, res, next)->
		res.render 'backoffice/auth',
			title : 'Admin'

	router.post '/', passport.authenticate 'local-login', { successRedirect: '/', failureRedirect: '/admin' }

	router.get '/activites', (req, res, next) ->
		res.render 'backoffice/activites',
			title: 'Les activités / région'

	router.post '/activites/add', (req, res, next)->
		activite = new Activite(req.body)
		activite.save (err, i)->
			if err
				result =
					ok: false
					msg: 'Une erreur est survenue.'
				res.send result
			else
				result =
					ok: true
					msg: 'L\'activité a bien été ajouté.'
				res.send result

	router.post '/activites/update/:id', (req, res, next)->
		activite = req.body
		delete activite._id;
		Activite.update({_id : req.params.id}, activite, {}, (err, numAffected)->
			if err
				result =
					ok: false
					msg: 'Une erreur est survenue.'
				res.send result
			else
				result =
					ok: true
					msg: 'L\'activité a bien été modifié.'
				res.send result
		)

	router.post '/activites/remove/:id', (req, res, next)->
		Activite.find({ _id:req.params.id }).remove (err)->
			if err
				result =
					ok: false
					msg: 'Une erreur est survenue.'
				res.send result
			else
				result =
					ok: true
					msg: 'L\'activité a bien été supprimé.'
				res.send result
