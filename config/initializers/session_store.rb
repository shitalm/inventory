# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ajax1_session',
  :secret      => 'e797c0053b62d8a678a17a98eed3c582bd36c206ebe3004f76377c63b7ba3630e76d1be2c8deceaf583517d476e299d1b89edc4948be23e4a3f1bbb275af6c00'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
