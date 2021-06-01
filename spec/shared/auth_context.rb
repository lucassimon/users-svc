# frozen_string_literal: true

require 'json_web_token'

RSpec.shared_context 'with jwt authentication', shared_context: :metadata do
  let(:user_id) { Faker::Number.within(range: 1..10_000) }
  let(:id_token) do
    {
      'session' => {
        'user' => {
          'id' => user_id
        }
      }
    }
  end
  # rubocop:disable RSpec/VariableName
  let(:Authorization) { 'Bearer token' }
  # rubocop:enable RSpec/VariableName

  before do
    allow(JsonWebToken).to receive(:verify).and_return(id_token)
  end
end

RSpec.shared_context 'with missing jwt authentication', shared_context: :metadata do
  # rubocop:disable RSpec/VariableName
  let(:Authorization) { nil }
  # rubocop:enable RSpec/VariableName

  before do
    allow(JsonWebToken).to receive(:verify).and_raise(JWT::VerificationError)
  end
end
