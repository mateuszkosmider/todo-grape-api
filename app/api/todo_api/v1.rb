# encoding: utf-8
class TodoApi::V1 < Grape::API
  version 'v1', using: :header, vendor: 'todo'

  helpers Api::Auth

  prefix 'api/todo'
  format :json

  rescue_from Mongoid::Errors::DocumentNotFound do |e|
    Rack::Response.new('Not found', 404, { "Content-type" => "text/error" }).finish
  end

  mount Token
  mount List
  mount Task

end
