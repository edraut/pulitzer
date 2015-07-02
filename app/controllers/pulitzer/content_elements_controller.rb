class Pulitzer::ContentElementsController < Pulitzer::ApplicationController

  def edit_multiple
    @post = Pulitzer::Post.find(params[:post_id])
    @content_elements = @post.content_elements
  end

  def update_multiple
    Pulitzer::ContentElement.update(params[:content_elements].keys,
      params[:content_elements].values)
    flash[:notice] = "Contents elements updated"
    redirect_to action: :edit_multiple
  end
end
