
require_relative 'credentials'
require 'faraday_middleware/escher'

conn = Faraday.new(url: 'http://localhost:9292') do |builder|

  builder.use FaradayMiddleware::Escher::RequestSigner,
              credential_scope: CredentialScope,
              options: AuthOptions,
              active_key: -> { Escher::Keypool.new.get_active_key('EscherExample') }

  builder.adapter :net_http


end

puts "\nResponse:",
     conn.get { |r|
       r.url('/')
       r.body='{ "name": "Unagi" }'
       r.params['kutya1']= 'cica1'
       r.params['kutya2']= 'cica2'
     }.body.inspect
