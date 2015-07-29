class Admin::HomeContentsController < ApplicationController
  def index
  end

  def create
    HomeContent.create!(
      title: params[:home_content][:title],
      content: params[:home_content][:content]
    )
    flash[:success] = 'Post created.'
    redirect_to admin_home_contents_path
  end

  def update
    HomeContent.find(params[:id]).update!(
      title: params[:home_content][:title],
      content: params[:home_content][:content]
    )
    flash[:success] = 'Post updated.'
    redirect_to admin_home_contents_path
  end

  def destroy
    HomeContent.find(params[:id]).destroy
    flash[:success] = 'Post deleted.'
    redirect_to admin_home_contents_path
  end

end
