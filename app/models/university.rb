# app/models/university.rb
class University < ApplicationRecord

  has_many :users, dependent: :destroy
  has_and_belongs_to_many :subjects
  has_one :domain, dependent: :destroy
   
  accepts_nested_attributes_for :domain

  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates_associated :domain

end
