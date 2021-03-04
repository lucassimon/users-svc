# frozen_string_literal: true

require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true, # Verify the signature of this token
               algorithms: 'RS256',
               iss: Settings.api.secure.issuer,
               verify_iss: true,
               jwks: jwks_hash)
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI(Settings.api.secure.jwks_uri)
    JSON.parse(jwks_raw, symbolize_names: true)
  end
end
