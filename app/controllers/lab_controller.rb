class LabController < ApplicationController
  layout "lab"
  
  def index
    render Views::Lab::Index.new
  end
end