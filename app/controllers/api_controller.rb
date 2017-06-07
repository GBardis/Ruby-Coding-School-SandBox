class ApiController < ApplicationController
  @@client = Elasticsearch::Client.new url: 'https://kteam:draewjUgbksIjcv19epwhpkcpnzieqkn@159.8.53.13:443',
                                       transport_options: {ssl: {ca_file: 'public/elasticsearch_cert.pem'}}
  @@index_name = 'threatdb_2017.06.02'


  # http://localhost:3000/api/{term}/page_size/{page_size}/page_num/{page_num}/exact_search/{exact_search}/order_by/{order_by}/order_by_direction/{order_by_direction}
  # http://localhost:3000/api/66.197.114/page_size/15/page_num/3
  def search

    if (!params.has_key?(:term) || !params[:term] || params[:term].length == 0)
      render json: '' and return
    end
    if params.has_key?(:page_size)
      page_size = Integer(params[:page_size]) rescue 0
    else
      page_size = 10
    end
    if params.has_key?(:page_num)
      page_num = Integer(params[:page_num]) rescue 0
    else
      page_num = 0
    end
    if (params.has_key?(:exact_search) && params[:exact_search] == 'false')
      exact_search = false
    else
      exact_search = true
    end

    if (params.has_key?(:order_by))
      order_by = params[:order_by]
    else
      order_by = ''
    end

    if (params.has_key?(:order_by_direction))
      order_by_direction = params[:order_by_direction]
    else
      order_by_direction = ''
    end

    @data = elastic_search params[:term], page_size, page_num, exact_search, order_by, order_by_direction
    render json: @data['hits']['hits']
  end

  def elastic_search(term, page_size = 10, page_num = 0, exact_search = true, order_by = '', order_by_direction = 'asc')
    # check input types?
    if exact_search
      query_term = "{\"term\":{\"threat_id\":\"#{term}\"}}"
    else
      query_term = "{\"wildcard\":{\"threat_id\":\"*#{term}*\"}}"
    end
    if order_by != ''
      sort = "{ \"#{order_by}\" : {\"order\" : \"#{order_by_direction}\"}}"
    end
    body = "{\"query\":{\"bool\":{\"must\":[#{query_term}],\"must_not\":[],\"should\":[]}},\"from\":#{page_num},\"size\":#{page_size},\"sort\":[#{sort}],\"aggs\":{}}"
    puts body

    return @@client.search index: @@index_name, body: body
  end

  def search2
    #@data = elastic_search params[:term], page_size, page_num, exact_search, order_by, order_by_direction
    draw = params[:draw]
    recordsTotal = 57 #@data['hits']['total']
    recordsFiltered = 11 #@data['hits']['total']
    data = [['Bradley', 'Greer', 'Software Engineer', 'London', '13th Oct 12', '$132,000', 'edit', 'delete' ]]
    render json: {'draw': draw, 'recordsTotal': recordsTotal, 'recordsFiltered': recordsFiltered, 'data': data}
  end


end


