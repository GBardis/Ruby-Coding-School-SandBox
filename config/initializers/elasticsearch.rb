url_key = "https://kteam:draewjUgbksIjcv19epwhpkcpnzieqkn@159.8.53.13:443"
config = {url: url_key, transport_options: {ssl: {ca_file: 'public/elasticsearch_cert.pem'}}}

Elasticsearch::Persistence.client = Elasticsearch::Client.new(config)
# Search.__elasticsearch__.client = Elasticsearch::Client.new(config)
Elasticsearch::Model.client = Elasticsearch::Client.new(config)
