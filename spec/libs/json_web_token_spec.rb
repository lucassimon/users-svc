# frozen_string_literal: true

require 'rails_helper'
require 'json_web_token'

RSpec.describe JsonWebToken, type: :lib do
  subject { described_class }

  let(:jwk) { JWT::JWK.new(OpenSSL::PKey::RSA.new(2048)) }
  let(:payload) do
    {
      'session' => {
        'user' => {
          'id' => Faker::Number.number(digits: 2)
        }
      }
    }
  end
  let(:headers) { { kid: jwk.kid } }
  let(:token) { JWT.encode payload, jwk.keypair, 'RS256', headers }

  it 'decode a jwt token' do
    allow(Net::HTTP).to receive(:get).and_return({ keys: [jwk.export] }.to_json)
    expect(described_class.verify(token).first).to eq(payload)
  end
end
