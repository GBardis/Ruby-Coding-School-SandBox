class SearchController < ApplicationController
  require 'elasticsearch/persistence/model'
  require 'elasticsearch/dsl'

  def index
    if !params[:q]
      @Search = Search.all(query: { match: {country_code: 'eth'}})
    else
      @Search = Search.all(query: { match: {country_code: params[:q]}}) unless params[:q].nil?
    end
  end

  def edit
    @Search = Search.search(query:{match: {_id: params[:id]}}).first
  end

  def update
    @Search = Search.search(query:{match: {_id: params[:id]}}).first
    @Search.update_attributes(
      threat_id: params[:threat_id],
      asn_registry: params[:asn_registry],
      threat_tri: params[:threat_tri].to_f,
      risk: params[:risk].to_f,
      country:  params[:country],
      asn:  params[:asn]
    )

    sleep 3
    flash[:success] = 'Record successfully updated!'
    redirect_to search_index_path
  end
  def destroy
    begin
      @s = Search.search(query:{match: {_id: params[:id]}}).first
      @s.destroy
      flash[:success] = 'Record successfully deleted!'  if @s.destroyed?
    rescue
    end
    sleep 3
    redirect_to search_index_path
  end
end
