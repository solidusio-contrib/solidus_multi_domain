require 'spec_helper'

describe Spree::Admin::StoresController do
  stub_authorization!

  describe '#index' do
    render_views

    it 'renders' do
      spree_get :index
      expect(response).to be_success
    end
  end

  describe '#edit' do
    render_views

    let(:store) { create(:store) }

    it 'renders' do
      spree_get :edit, id: store.to_param
      expect(response).to be_success
    end
  end
end
