require 'rails_helper'

describe Pulitzer::ContentElementsController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:custom_option) {Pulitzer::CustomOption.find_by value: 'contactMgmt'}
  let(:custom_option_list) {custom_option.custom_option_list}
  let(:cet) {Pulitzer::ContentElementType.find_by name: 'Clickable'}
  let(:content_element) {Pulitzer::ContentElement.find_by content_element_type_id: cet.id}

  describe "content_elements", type: :request do
    it "updates a clickable with a custom option" do
      content_element.update body: 'remove me'
      expect(content_element.custom_option_id).not_to eq custom_option.id
      patch pulitzer.content_element_path(id: content_element.id, content_element:{
        clickable_kind: custom_option_list.gid, custom_option_id: custom_option.id
        })
      expect(response.status).to eq 200
      expect(content_element.reload.custom_option_id).to eq custom_option.id
      expect(content_element.body).to be nil
    end

    it "updates a clickable with a url" do
      content_element.update custom_option_id: custom_option.id
      expect(content_element.body).not_to eq 'http://google.com'
      patch pulitzer.content_element_path(id: content_element.id, content_element:{
        clickable_kind: 'url', body: 'http://google.com'
        })
      expect(response.status).to eq 200
      expect(content_element.reload.custom_option_id).to be nil
      expect(content_element.body).to eq 'http://google.com'
    end
  end
end
