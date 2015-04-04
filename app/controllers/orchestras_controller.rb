class OrchestrasController < ApplicationController

  def show
    @orchestra = Orchestra.find(params[:id])
    @concerts = Concert.where(orchestra_id: params[:id])
  end
end
