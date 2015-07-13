class BlogsController < ApplicationController
  def new
  end

  def create
    @blog = Blog.new(title: params[:title], image: params[:image], body: params[:body])

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
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
