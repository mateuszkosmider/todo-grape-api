# encoding: utf-8
class List
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  belongs_to :user
  has_many :tasks

  def entity
    Entity::List.new(self)
  end
end