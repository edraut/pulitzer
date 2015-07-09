class PagesController < ApplicationController
  def about_us
    @pulitzer_post = Pulitzer::PostType.named('About us').singleton_post
  end
end
