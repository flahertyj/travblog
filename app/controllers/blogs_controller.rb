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
    @all_blogs = retrieve_all_blogs(true)
  end

  def retrieve_all_blogs(desc)
    if (desc)
      Blog.order('id DESC').all
    else
      Blog.all
    end
  end

  def retrieve_blog(id)
    Blog.find(id)
  end
end
