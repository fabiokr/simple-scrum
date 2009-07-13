# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_personal-scrum_session',
  :secret      => '29d88f55dfaeacfce9af696b2e9fb243716d70bca0e49182b13e9b458f9b8699dfa2043d6f5ca892163d7c60590279073665b714bb7aa33ff491c023971872a5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
