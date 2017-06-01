class ElasticController < ApplicationController
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def elastic
    client = Elasticsearch::Model.client
    client = Elasticsearch::Client.new url: 'https://kteam:draewjUgbksIjcv19epwhpkcpnzieqkn@159.8.53.13:443',
    transport_options: {
      ssl: {
        ca_file: 'public/elasticsearch_cert.pem',
      }
    }

    #  @response = client.search index:'threatdb_2017.05.26',body:{"query":{"bool":{"must":{"query_string":{"default_field":"threatdb_tri.threat_type","query":"t_spamip"}},"must_not":[],"should":[]}},"from":0,"size":1,"sort":[],"aggs":{}}

    @response = client.search index:'threatdb_2017.05.26',body:{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":100,"sort":[],"aggs":{}}
    @result = JSON.parse(JSON.dump(@response.as_json))
    @obj = Hashie::Mash.new @result
  end
  def elastic_second
    client = Elasticsearch::Model.client
    client = Elasticsearch::Client.new url: 'https://kteam:draewjUgbksIjcv19epwhpkcpnzieqkn@159.8.53.13:443',
    transport_options: {
      ssl: {
        ca_file: 'public/elasticsearch_cert.pem',
      }
    }
    @threatdb_tri = client.search index:'threatdb_2017.05.26',body:{"query":{"bool":{"must":[{"match_all":{}}],"must_not":[],"should":[]}},"from":0,"size":10,"sort":[{ "threat_tri":{"order":"desc"}}],"aggs":{}}
    @result_second = JSON.parse(JSON.dump(@threatdb_tri.as_json))
    @obj_second = Hashie::Mash.new @result_second
  end
end
