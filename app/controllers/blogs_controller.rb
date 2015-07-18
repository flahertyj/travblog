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
    @blog = retrieve_blog(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    blog_param = params[:blog]

    respond_to do |format|
      if @blog.update(title: blog_param[:title], image: blog_param[:image], body: blog_param[:body])
        format.html { redirect_to @blog, notice: 'Blog was successfully edited.' }
      else
        format.html { render action: "index" }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.destroy
        format.html { redirect_to action: "index", notice: 'Blog was successfully destroyed.' }
      else
        format.html { render action: "show", id: params[:id] }
      end
    end
  end

  def show
    @blog = retrieve_blog(params[:id])
    @commenter_name = commenter_name
    @comments = retrieve_comments
  end

  def index
    @all_blogs = retrieve_all_blogs(true)
    @current_location = [Location.last]
    @hash = Gmaps4rails.build_markers(@current_location) do |location, marker|
      marker.lat location.lat
      marker.lng location.lng
    end
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

  def commenter_name
    current_user ? current_user.username : 'Anonymous'
  end

  def retrieve_comments
    Blog.find(@blog.id).comments
  end

  private

    def blog_params
      # It's mandatory to specify the nested attributes that should be whitelisted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.require(:blog).permit(:title, :image, :body)
    end
end
