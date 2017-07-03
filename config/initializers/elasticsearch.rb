url_key =  ENV['CRYPTIA_ELASTIC_URL'] || File.read('.secrets/url').strip
config = {url: url_key, transport_options: {ssl: {ca_file: 'public/elasticsearch_cert.pem'}}}

Elasticsearch::Persistence.client = Elasticsearch::Client.new(config)
# Search.__elasticsearch__.client = Elasticsearch::Client.new(config)
Elasticsearch::Model.client = Elasticsearch::Client.new(config)
