# Example model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

ChaletSchema = new Schema(
  nom: String
  img_principale : String
  gallerie : Array
  capacite : String
  description : String
  inventaire : [
  	nom : String
  	item: Array
  ]
)

ChaletSchema.virtual('date')
  .get (-> this._id.getTimestamp())

mongoose.model 'Chalet', ChaletSchema
