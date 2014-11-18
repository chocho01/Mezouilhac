# config/passport.js

# load all the things we need
LocalStrategy = require("passport-local").Strategy

auth = 
  login : 'chocho'
  mdp: 'mezouilhac'

# expose this function to our app using module.exports
module.exports = (passport) ->

  # used to serialize the user for the session
  passport.serializeUser (user, done) ->
    done null, user
    return


  # used to deserialize the user
  passport.deserializeUser (id, done) ->
    done null, id
    return

  
  passport.use "local-login", new LocalStrategy(
    
    # by default, local strategy uses username and password, we will override with email
    usernameField: "login"
    passwordField: "password"
    passReqToCallback: true # allows us to pass back the entire request to the callback
  , (req, login, password, done) -> # callback with email and password from our form
    # On crypte le mot de passe
    mdp = password

    # # Authentification en dur
    if login != auth.login
       return done(null, false, req.flash("loginMessage", "L'utilisateur est incorrect."))
    else if mdp != auth.mdp
       return done(null, false, req.flash("loginMessage", "Le mot de passe est incorrect."))
    else
       done null, login

  )
  return