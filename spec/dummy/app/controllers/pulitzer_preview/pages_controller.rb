class PagesController < ApplicationController
  def about_us
    @pulitzer_post = Pulitzer::PostType.named('About us').singleton_post.get_preview_version!
  end

  def news_posts
    @pulitzer_posts = Pulitzer::PostType.named('News articles').posts.get_preview_version!
  end

#Pulitzer Generated Actions

  def welcome
    @post = Pulitzer::PostType.named('Welcome').posts.find_by!(slug: params[:slug]).get_preview_version!
  end

end
