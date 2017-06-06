#require 'elasticsearch-persistence'
url_key = File.read('.secrets/url').strip
config = {
  host: url_key,
  transport_options: { ssl: {
    ca_file: 'public/elasticsearch_cert.pem',
     }
    }
   }

Elasticsearch::Persistence.client = Elasticsearch::Client.new(config)
