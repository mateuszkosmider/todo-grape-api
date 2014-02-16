# encoding: utf-8
require 'test_helper'

class Api::ListTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    TodoApi::V1
  end

  def setup
    TodoApi::V1.helpers do
      # Skip authentiation
      def authenticated?
        true
      end

      def current_user
        User.new(email: 'test@user.pl')
      end
    end
  end

  test "#get should return json with lists" do
    User.any_instance.stubs(:lists).returns([ List.new(title: 'First'), List.new(title: 'Sample') ])
    
    get 'api/todo/lists'
    response_json = JSON.parse(last_response.body)

    assert response_json.size, 2
    assert response_json[0]['title'], 'First'
    assert response_json[1]['title'], 'Sample'
    assert_not_nil response_json[0]['_id']
  end

  test "#post should return json with created list" do
    List.any_instance.stubs(:save).returns(true)

    post 'api/todo/lists', { title: 'Sample list' }

    response_json = JSON.parse(last_response.body)

    assert response_json['title'], 'Sample list'
    assert_not_nil response_json['_id']
  end

end