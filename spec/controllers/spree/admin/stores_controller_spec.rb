# frozen_string_literal: true

require 'solidus_multi_domain_spec_helper'

RSpec.describe Spree::Admin::StoresController do
  routes { Spree::Core::Engine.routes }
  stub_authorization!

  describe '#index' do
    render_views

    it 'renders' do
      get :index
      expect(response).to be_successful
    end
  end

  describe '#edit' do
    render_views

    let(:store) { create(:store) }

    it 'renders' do
      get :edit, params: { id: store.to_param }
      expect(response).to be_successful
    end
  end
end
