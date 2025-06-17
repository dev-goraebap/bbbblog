class LabController < ApplicationController
  layout "lab"
  
  def index
    render "lab/index"
  end
end