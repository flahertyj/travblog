class BlogsController < ApplicationController
  def index
    @all_blogs = retrieve_all_blogs(true)

    last_loc = Location.last
    @current_location = last_loc ? [last_loc] : [Location.new(name: 'Denver, CO', latitude: 39.7392, longitude: -104.9903)]
    @hash = Gmaps4rails.build_markers(@current_location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
    end

    @instagram = Instagram.user_recent_media("630271193", {count: 8})
  end

  def new
  end

  def create
    @blog = Blog.new(title: params[:title], body: params[:body])

    respond_to do |format|
      if @blog.save
        (0..11).each do |n|
          image_sym = "image_#{n}".to_sym

          if params[image_sym].present?
            new_image = @blog.images.new(name: params[image_sym])
            new_image.save
          end
        end
        format.html { redirect_to @blog }
      else
        format.html { render action: "new", notice: "Blog was not created @blog.errors.full_messages.to_sentence" }
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
      if @blog.update(title: blog_param[:title], body: blog_param[:body])
        (0..11).each do |n|
          image_sym = "image_#{n}".to_sym

          if params[image_sym].present?
            new_image = @blog.images.new(name: params[image_sym])
            new_image.save
          end
        end

        format.html { redirect_to @blog }
      else
        format.html { render action: "index" }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.destroy
        format.html { redirect_to action: "index" }
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
