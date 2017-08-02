module Pulitzer
  module ControllerHelpers
    def pulitzer_view_path(version_number)
      File.join Pulitzer.public_controller,
        action_name,
        "v_#{version_number.to_s}.html.erb"
    end

    def get_active_post(post_type_name)
      @post_type_version = Pulitzer::PostType.named(post_type_name).published_type_version
      @post = get_post_for_version(@post_type_version,:active)
      return @post, @post_type_version
    end

    def get_preview_post(post_type_name)
      @post_type_version = Pulitzer::PostType.named(post_type_name).post_type_versions.find_by(version_number: params[:version_number])
      @post = get_post_for_version(@post_type_version,:preview)
      return @post, @post_type_version
    end

    def get_post_for_version(ptv,status)
      if ptv.present?
        if ptv.plural?
          ptv.posts.find_by!(slug: params[:slug]).send "get_#{status}_version!"
        else
          ptv.singleton_post.send "get_#{status}_version!"
        end
      else
        nil
      end
    end

  end
end