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

	router.get '/chalet/:id', (req, res, next) ->

		Chalet.find {_id:req.params.id}, (err, chalet) ->
			return next(err) if err
			res.send chalet
			