class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to root_path, notice: "Yeah, your picture was uploaded succesfully!"
		else
      redirect_to root_path
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post, notice: "Post was successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	#def upvote
	#	@post.upvote_by current_user
	#	redirect_to @post
	#end

	private

	def post_params
		params.require(:post).permit(:title, :caption, :image)
	end

	def set_post
		@post = Post.find(params[:id])
	end

end
