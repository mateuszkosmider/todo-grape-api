# encoding: utf-8
class TodoApi < Grape::API
  mount TodoApi::V1

  add_swagger_documentation
end