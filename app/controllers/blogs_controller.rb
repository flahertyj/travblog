class BlogsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def show
    @blog = retrieve_blog(params[:id])
  end

  def index
    @all_blogs = retrieve_all_blogs
  end

  def retrieve_all_blogs
    Blog.all
  end

  def retrieve_blog(id)
    Blog.find(id)
  end
end
