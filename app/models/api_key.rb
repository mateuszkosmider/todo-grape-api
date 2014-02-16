# encoding: utf-8
class ApiKey < ActiveRecord::Base
  include Mongoid::Document

  before_create :generate_access_token
  belongs_to :user

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end