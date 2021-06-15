module Profiles
  class Session
    def initialize(foo)
      @foo = foo
    end
    def test
      response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
      "InputAsdadasdasdasdasdasdas: #{@foo} #{response.body} #{response.code}"
    end
  end
end
