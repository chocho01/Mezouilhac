# Example model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

ActiviteSchema = new Schema(
  nom : String
  categorie : String
  position :
    latitude : Number
    longitude : Number
  adresse: String
  icon : String
)

# ChaletSchema.virtual('date')
#   .get (-> this._id.getTimestamp())

mongoose.model 'Activite', ActiviteSchema
