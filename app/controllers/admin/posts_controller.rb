class Admin::PostsController < ApplicationController
  def new
    render Views::Admin::Post::New.new, layout: "form"
  end
end
