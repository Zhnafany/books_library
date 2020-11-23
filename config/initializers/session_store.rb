# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_library_session',
  :secret      => 'aaf93755e3395f48709f21d866a7d8084167d4ae9588061e69003f4eca2e9e337d0c2931e2a551c5f8cd47a3011ec489107f6944fff14dd5f11d26021f9fe5cb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
