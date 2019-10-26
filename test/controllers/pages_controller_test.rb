# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get info' do
    get pages_info_url
    assert_response :success
  end

  test 'should get gallery' do
    get pages_gallery_url
    assert_response :success
  end
end
