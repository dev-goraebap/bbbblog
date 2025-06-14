class Admin::PostsController < ApplicationController
  def new
    render Views::Admin::Post::New.new, layout: "form"
  end

  def create
    puts params.inspect
  end
end
