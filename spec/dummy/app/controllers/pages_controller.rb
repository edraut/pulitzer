class PagesController < ApplicationController
  def about_us
    @pulitzer_post = Pulitzer::PostType.named('About us').singleton_post
  end

  def news_posts
    @pulitzer_posts = Pulitzer::PostType.named('News articles').posts
  end

#Pulitzer Generated Actions

  def welcome
    post_type_version = Pulitzer::PostType.named('Welcome').published_type_version
    @post = post_type_version.posts.find_by!(slug: params[:slug]).get_active_version!
  end

end
