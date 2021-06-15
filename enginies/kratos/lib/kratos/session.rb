module Kratos
  class Session
    include HTTParty
  
    # TODO: get from ENV or initialize it on contructor?
    base_uri "http://6ca67a1e2bc7.ngrok.io"
  
    class HTTPRequestError < StandardError; end
  
    class HTTPRequestServerError < StandardError; end
  
    class HTTPRequestNotFound < StandardError; end
  
    class HTTPRequestConflict < StandardError; end
  
    class HTTPRequestBadRequest < StandardError; end
  
    def initialize
        super
        @default_options = { headers: { Accept: 'application/json' } }
    end
    
    def create_identity(body)
        options = { 
            headers: { 'Content-type' => 'application/json' }.merge!(@default_options[:headers]), 
            body: body.to_json 
        }
        
        response = self.class.post('/identities', options)
  
        raise_exception response unless response.code == 201
  
        # TODO: Change for the output::as_json::json_response
        json_response response.body
    end
  
    def get_identity(identity_id)
        response = self.class.get("/identities/#{identity_id}", @default_options)
        raise_exception response unless response.code == 200
    
        json_response response.body
    end
  
    def delete_identity(identity_id)
        response = self.class.delete("/identities/#{identity_id}", @default_options)
        raise_exception response unless response.code == 204
    end
  
    # Source: https://www.ory.sh/kratos/docs/self-service/flows/user-registration/#api-clients
    # For API Clients, Ory Kratos responds with a JSON payload which includes the signed up identity:
    # Payload: { schema_id: 'default', "password": "foo_bar_123", traits: { 'email' => 'teste18@gmail.com' }}
    def register(payload)
  
        # TODO: Get the flow ID from the api client
        response_flow = get_registration_api
  
        
        
        # TODO: Check errors
        raise_exception response_flow unless response_flow.code == 200
  
        
  
        # TODO: Get the flow id
        # the id is the same on the parameter ?flow_id='' on json['ui']['action']
        flow_id = json_response(response_flow.body)[:id]
  
        
  
        # TODO: With the flow ID we can POST data
        response_registration = post_registration_api(payload, flow_id)
  
        
        
        # TODO: Check errors
        raise_exception response_registration unless response_registration.code == 200
  
        
  
        # TODO: Change for the output::as_json::json_response
        json_response response_registration.body
    end
  
    # Example with curl
    # TODO: Get the flow ID from the api client 
    # curl -s -X GET -H "Accept: application/json"  "http://127.0.0.1:4433/self-service/registration/api"   
    # {
    #     "id": "bbcc3c08-9767-45fc-8237-b963d511cb71",
    #     "type": "api",
    #     "expires_at": "2021-06-09T21:53:48.569408795Z",
    #     "issued_at": "2021-06-09T21:43:48.569408795Z",
    #     "request_url": "http://127.0.0.1:4433/self-service/registration/api",
    #     "ui": {
    #       "action": "http://127.0.0.1:4433/self-service/registration?flow=bbcc3c08-9767-45fc-8237-b963d511cb71",
    #       "method": "POST"
    #       "nodes": [....]
    #     }
    # }
    def get_registration_api()
        options = { 
            headers: { 'Content-type' => 'application/json' }.merge!(@default_options[:headers]) 
        }
        # TODO: Call the request
        response = self.class.get('/self-service/registration/api', options)
  
        # TODO: Raise an expection here or let the register method dispatch it
  
        # TODO: Return the response
        response
    end
  
  
    # TODO: With the flow ID (.ui.action) we can POST data
    # curl -s 
    # -X POST 
    # -H  "Accept: application/json" 
    # -H "Content-Type: application/json" 
    # -d '{
    #     "traits.email": "teste17@gmail.com", 
    #     "password": "foo_bar_123", 
    #     "method": "password"
    # }' 
    # http://127.0.0.1:4433/self-service/registration?flow=bbcc3c08-9767-45fc-8237-b963d511cb71
  
    # Should return the response
    # {
    #     "identity": {
    #       "id": "d8baf63b-7ce6-4275-82b9-9ac6d97e5037",
    #       "schema_id": "default",
    #       "schema_url": "http://127.0.0.1:4433/schemas/default",
    #       "traits": {
    #         "email": "registration-api@user.org"
    #       },
    #       "verifiable_addresses": [
    #         {
    #           "id": "87defb49-ad69-461c-b5f6-56c1ec39dd39",
    #           "value": "registration-api@user.org",
    #           "verified": false,
    #           "via": "email",
    #           "status": "pending",
    #           "verified_at": null
    #         }
    #       ],
    #       "recovery_addresses": [
    #         {
    #           "id": "232793b8-8d60-427d-89e6-d0a97a7a172c",
    #           "value": "registration-api@user.org",
    #           "via": "email"
    #         }
    #       ]
    #     }
    # }
    # Payload: { schema_id: 'default', password: 'abcedarium', traits: { 'email' => 'teste17@gmail.com' }}
    def post_registration_api(payload, flow_id)
        body = {'method': 'password'}.merge!(payload)
  
        options = { 
            headers: { 'Content-type' => 'application/json' }.merge!(@default_options[:headers]),
            query: { 'flow' => flow_id },
            body: body.to_json 
        }
  
        # TODO: Call the request
        response = self.class.post('/self-service/registration', options)

        # TODO: Raise an expection here or let the register method dispatch it
  
        # TODO: Return the response
        response
    end
  
    # Source: https://www.ory.sh/kratos/docs/self-service/flows/user-login#api-clients
    # For API Clients, Ory Kratos responds with a JSON payload which includes the identity which just authenticated, the session, and the Ory Kratos Session Token:
    def login(payload)
  
    end
  
    def verification(payload)
  
    end
  
    def json_response(body)
        JSON.parse body, symbolize_names: true
    end
  
    def raise_exception(response)
        message = json_response(response.body)[:error][:message]
  
        raise HTTPRequestBadRequest, message if response.code == 400
        raise HTTPRequestNotFound, message if response.code == 404
        raise HTTPRequestConflict, message if response.code == 409
        raise HTTPRequestServerError, message if response.code == 500
    
        raise HTTPRequestError, message
    end
  end  
end
