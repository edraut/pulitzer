require 'rails'
require 'thin_man'
require 'hooch'
require 'carrierwave'
require 'friendly_id'
require 'select2-rails'
require 'pulitzer/engine'
require 'pulitzer/exceptions'
require 'state_machine/model'
require 'state_machine/transition'

module Pulitzer
  mattr_accessor  :base_controller, :metadata_closure, :authentication_closure, :unpublish_authorization,
  :publish_callback, :tagging_models, :layout, :text_editor_toolbars, :clone_queue, :image_queue, :aws_acl,
  :partial_folder, :missing_image_path, :public_view_dir, :public_controller, :preview_namespace

  def self.config(options)
    base_controller_name = options[:base_controller_name]
    @@base_controller         = base_controller_name.constantize
    @@missing_image_path      = options[:missing_image_path] || "/assets/missing.png"
    @@metadata_closure        = options[:metadata_authorization]
    @@authentication_closure  = options[:authentication]
    @@unpublish_authorization = options[:unpublish_authorization]
    @@publish_callback        = options[:publish_callback]
    @@tagging_models          = options[:tagging_models] || []
    @@layout                  = options[:layout] || 'application'
    @@partial_folder          = options[:partial_folder] || 'pulitzer_partials'
    @@preview_namespace       = options[:preview_namespace] || 'pulitzer_preview'
    @@public_controller       = options[:public_controller] || 'pulitzer'
    default_text_editor       = [{ name: 'None', template: 'pulitzer/text_editors/none', kind: 'TinyMCE'}]
    user_text_editors         = options[:text_editor_toolbars].flatten || nil
    @@text_editor_toolbars    = default_text_editor.push(*user_text_editors).compact
    if options.has_key?( :active_job_queues)
      queue_options = options[:active_job_queues]
      @@clone_queue           = queue_options.has_key?(:clone_post_version) ? queue_options[:clone_post_version] : :default
      @@image_queue           = queue_options.has_key?(:image_queue) ? queue_options[:image_reprocessing] : :default
    else
      @@clone_queue           = :default
      @@image_queue           = :default
    end
    @@aws_acl                 = options[:aws_acl] if options.has_key? :aws_acl
  end

  def self.skip_metadata_auth?
    self.metadata_closure.blank?
  end

  def self.skip_authentication?
    self.authentication_closure.blank?
  end

  def self.skip_publish_callback?
    self.publish_callback.blank?
  end
end
