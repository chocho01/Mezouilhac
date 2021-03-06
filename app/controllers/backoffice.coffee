express  = require 'express'
router = express.Router()
passport = require 'passport'
mongoose = require 'mongoose'
gm = require('gm').subClass({ imageMagick: true })
multer  = require 'multer'
fs = require 'fs'
Activite  = mongoose.model 'Activite'
Chalet  = mongoose.model 'Chalet'

isAuth = (req, res, next) ->
	# if user is authenticated in the session, carry on
	return next()  if req.isAuthenticated()
	# if they aren't redirect them to the home page
	res.redirect "/admin"
	return

module.exports = (app) ->
	app.use '/admin', router

	router.get '/', (req, res, next)->
		if !req.user
			res.render 'backoffice/auth',
				title : 'Admin'
				pageName: 'admin'
		else
			res.render 'backoffice/index',
				title : 'Admin'
				pageName: 'admin'

	router.post '/', passport.authenticate 'local-login', { successRedirect: '/admin', failureRedirect: '/admin' }

	router.get '/activites', isAuth, (req, res, next) ->
		res.render 'backoffice/activites',
			title: 'Les activités / région'
			pageName: 'admin'

	router.get '/chalets', isAuth, (req, res, next) ->
		res.render 'backoffice/chalets',
			title: 'Les chalets'
			pageName: 'admin'

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
				rres.send
					ok: false
					msg: 'Une erreur est survenue.'
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


	router.post '/chalets/upload', multer({ dest: './uploads/'}),(req, res, next)->
		pathImage = req.files.file.path
		name = req.files.file.originalname
		name_min = name.substring(0, name.length-4)+'-min'+name.substring(name.length-4)
		gm(pathImage).resize('150', '150', '^').gravity('Center').crop('150', '150').write './public/img/chalets/'+name_min, (err) ->
			if err
				res.send 500
			else
				gm(pathImage).resize('400', '275', '^').gravity('Center').crop('400', '275').write './public/img/chalets/'+name, (err) ->
					res.send 500 if err
					res.send pathImage if!err


	router.post '/chalets/add', (req, res, next)->
		chalet = new Chalet(req.body)
		chalet.save (err, i)->
			if err
				result =
					ok: false
					msg: 'Une erreur est survenue.'
				res.send result
			else
				result =
					ok: true
					msg: 'Le chalet a bien été ajouté.'
				res.send result

	router.post '/chalets/update/:id', (req, res, next)->
		chalet = req.body
		delete chalet._id;
		Chalet.update({_id : req.params.id}, chalet, {}, (err, numAffected)->
			if err
				result =
					ok: false
					msg: 'Une erreur est survenue.'
				res.send result
			else
				result =
					ok: true
					msg: 'Le chalet a bien été modifié.'
				res.send result
		)

	router.post '/chalets/remove/:id', (req, res, next)->
		Chalet.find({ _id:req.params.id }).remove (err)->
			if err
				result =
					ok: false
					msg: 'Une erreur est survenue.'
				res.send result
			else
				result =
					ok: true
					msg: 'Le chalet a bien été supprimé.'
				res.send result