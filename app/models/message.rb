class Message < ApplicationRecord
	belongs_to :user
	has_many :comments
  
	validates :title, :description, :presence => true
	validates :title, :length => { :minimum => 2 }
	validates :title, :uniqueness => { :message => ' is Already Taken'}
end
