class PagesController < ApplicationController
  def about_us
    @pulitzer_post = Pulitzer::PostType.named('About us').singleton_post
  end

  def news_posts
    @pulitzer_posts = Pulitzer::PostType.named('News articles').posts
  end
end
