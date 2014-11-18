# Example model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

ChaletSchema = new Schema(
  nom: String
  image: 
  	principale : String
  	galerie : Array
  capacite : String
  description_courte : String
  inventaire : [
  	categorie : String
  	contenu: Array
  ]
)

ChaletSchema.virtual('date')
  .get (-> this._id.getTimestamp())

mongoose.model 'Chalet', ChaletSchema
