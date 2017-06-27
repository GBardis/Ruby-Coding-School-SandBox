# Documentation # TODO: Documentation
class ApiController < ApplicationController
  require 'elasticsearch/persistence/model'
  require 'elasticsearch/dsl'

  def search
    term = '', page_size = 10, page_num = 0, exact_search = true, order_by = '_score', direction = 'desc', regex = false
    term = params[:term] if params.key?(:term)
    regex = params[:regex] if params.key?(:regex)
    page_size = params[:page_size].to_i if params.key?(:page_size)
    page_num = params[:page_num].to_i if params.key?(:page_num)
    order_by = params[:order_by] if params.key?(:order_by)
    direction = 'asc' if params.key?(:direction) && params[:direction] == 'asc'
    search_result = Search.search query: { term: { threat_id: term } },
                                  size: page_size, from: page_num, sort: [{ order_by.to_sym => direction }]
    render json: search_result
  end

  def threat
    if params.key?(:id)
      id = params[:id]
      search_result = Search.search query: { term: { threat_id: id } }, size: 1
      render json: search_result
    end
  end

  def analytics
    @search = Search.search(query: { match_all: {} },
                            size: 10, sort: [threat_tri: { order: 'desc' }])
    @search_country = Search.search(size: 0,
                                    aggs: { group_by_country: { terms: { field: 'country.raw' } } })
    @search_by_tri = Search.search(size: 0,
                                   aggs: { group_by_country: { terms: { field: 'country.raw',
                                                                        order: { average_threat_tri: 'desc' } },
                                                               aggs: { average_threat_tri: { max: { field: 'threat_tri' } } } } })
  end
end
