class Pulitzer::PostsController::Clone
  include Pulitzer::Engine.routes.url_helpers

  def initialize(post, new_post)
    @post               = post
    @new_post           = new_post
    @post_type_version  = new_post.post_type_version
  end

  def call
    published_type_version = @post.post_type.published_type_version
    @post_type_version.processed_element_count = 1
    published_type_version.post_type_content_element_types.each do |ptcet|
      begin
        @post_type_version.post_type_content_element_types << ptcet.clone_me
      rescue ActiveRecord::RecordInvalid => invalid
        error_message = "PostType Content Element Type #{ptcet.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
        add_post_type_error(error_message)
      end
    end
    if @post_type_version.kind == 'partial'
      published_type_version.background_styles.each do |bs|
        begin
          @post_type_version.background_styles << bs.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          error_message = "Background Styles #{bs.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
          add_post_type_error(error_message)
        end
      end
      published_type_version.justification_styles.each do |js|
        begin
          @post_type_version.justification_styles << js.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          error_message = "Justification Styles #{js.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
          add_post_type_error(error_message)
        end
      end
      published_type_version.sequence_flow_styles.each do |sfs|
        begin
          @post_type_version.sequence_flow_styles << sfs.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          error_message = "Sequence Flow Styles #{sfs.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
          add_post_type_error(error_message)
        end
      end
      published_type_version.arrangement_styles.each do |as|
        begin
          @post_type_version.arrangement_styles << as.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          error_message = "Arrangement Styles #{as.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
          add_post_type_error(error_message)
        end
      end
    elsif @post_type_version.kind == 'template'
      published_type_version.free_form_section_types.each do |ffst|
        begin
          @post_type_version.free_form_section_types << ffst.clone_me
        rescue ActiveRecord::RecordInvalid => invalid
          error_message = "Free Form Section Type #{ffst.id} could not be cloned: #{invalid.record.errors.full_messages.join(', ')}"
          add_post_type_error(error_message)
        end
      end
      published_type_version.posts.each do |post|
        Pulitzer::PostTypeVersionsController::ClonePostWithVersionElements.new(post, @post_type_version).call
        @post_type_version.processed_element_count += 1
        @post_type_version.broadcast_change if defined? ForeignOffice
      end
    end
    @post_type_version.finished_processing = post_path(@new_post)
    @post_type_version.broadcast_change if defined? ForeignOffice
    @post_type_version
  end


  def add_post_type_error(message)
    @post_type_version.processing_failed!
  end

end
