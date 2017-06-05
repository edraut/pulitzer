require 'rails_helper'

describe Pulitzer::PostTypeContentElementTypesController do
  routes { Pulitzer::Engine.routes }
  render_views

  let(:custom_option_list) {Pulitzer::CustomOptionList.find_by name: 'Sliders'}
  let(:cet) {Pulitzer::ContentElementType.find_by name: 'Clickable'}
  let(:post_type) {Pulitzer::PostType.create(name: 'Text and Action', plural: true, kind: :partial)}
  let(:post_type_content_element_type) {post_type.post_type_content_element_types.create label: 'Action Button', content_element_type_id: cet.id}

  describe "clickable_types", type: :request do
    it "renders the correct options for clickable_kinds" do
      get pulitzer.edit_post_type_content_element_type_path(post_type_content_element_type)
      expect(response.status).to eq 200
      expect(response.body).to match('value="any"')
      expect(response.body).to match('value="' + custom_option_list.gid + '"')
      expect(response.body).to match('value="url"')
    end

    it "creates with 'any' as a clickable_kind" do
      post pulitzer.post_type_content_element_types_path(
        post_type_content_element_type:{
          label: 'Action Button 2',
          content_element_type_id: cet.id,
          post_type_id: post_type.id,
          clickable_kind: 'any'
        }
      )
      expect(response.status).to eq 200
      ptcet = Pulitzer::PostTypeContentElementType.order(id: :desc).first
      expect(ptcet.label).to eq 'Action Button 2'
      expect(ptcet.content_element_type_id).to eq cet.id
      expect(ptcet.post_type_id).to eq post_type.id
      expect(ptcet.clickable_kind).to eq 'any'
    end

    it "creates with Sliders as a clickable_kind" do
      post pulitzer.post_type_content_element_types_path(
        post_type_content_element_type:{
          label: 'Action Button 2',
          content_element_type_id: cet.id,
          post_type_id: post_type.id,
          clickable_kind: custom_option_list.gid
        }
      )
      expect(response.status).to eq 200
      ptcet = Pulitzer::PostTypeContentElementType.order(id: :desc).first
      expect(ptcet.label).to eq 'Action Button 2'
      expect(ptcet.content_element_type_id).to eq cet.id
      expect(ptcet.post_type_id).to eq post_type.id
      expect(ptcet.custom_option_list.id).to eq custom_option_list.id
    end

    it "creates with 'url' as a clickable_kind" do
      post pulitzer.post_type_content_element_types_path(
        post_type_content_element_type:{
          label: 'Action Button 2',
          content_element_type_id: cet.id,
          post_type_id: post_type.id,
          clickable_kind: 'url'
        }
      )
      expect(response.status).to eq 200
      ptcet = Pulitzer::PostTypeContentElementType.order(id: :desc).first
      expect(ptcet.label).to eq 'Action Button 2'
      expect(ptcet.content_element_type_id).to eq cet.id
      expect(ptcet.post_type_id).to eq post_type.id
      expect(ptcet.clickable_kind).to eq 'url'
    end

    it "shows with a custom_option_list selected" do
      post_type_content_element_type.update clickable_kind: custom_option_list.gid
      get pulitzer.post_type_content_element_type_path(post_type_content_element_type)
      expect(response.status).to eq 200
      expect(response.body).to match('Action Button')
      expect(response.body).to match(cet.name)
      expect(response.body).to match(custom_option_list.name)
      expect(response.body).to match('Styles')
    end

    it "updates with 'url' as a clickable_kind" do
      post_type_content_element_type.update clickable_kind: custom_option_list.gid

      patch pulitzer.post_type_content_element_type_path(id: post_type_content_element_type.id, 
        post_type_content_element_type: {
          label: 'Action Button 2',
          content_element_type_id: cet.id,
          post_type_id: post_type.id,
          clickable_kind: 'url'
        }
      )
      expect(response.status).to eq 200
      expect(post_type_content_element_type.reload.label).to eq 'Action Button 2'
      expect(post_type_content_element_type.content_element_type_id).to eq cet.id
      expect(post_type_content_element_type.post_type_id).to eq post_type.id
      expect(post_type_content_element_type.clickable_kind).to eq 'url'
    end

    it 'deletes' do
      id = post_type_content_element_type.id
      delete pulitzer.post_type_content_element_type_path(post_type_content_element_type)
      expect(response.status).to eq 200
      expect(Pulitzer::PostTypeContentElementType.find_by(id: id)).to be nil
    end
  end
end
