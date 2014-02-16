# encoding: utf-8
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :complete, type: Boolean

  belongs_to :list

end