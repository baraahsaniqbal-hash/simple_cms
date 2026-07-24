class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # has_many :subjects, dependent: :destroy
  # has_many :pages, through: :subjects
  # has_many :sections, through: :pages
  
  belongs_to :university, optional: true, counter_cache: true
  has_and_belongs_to_many :subjects

  enum role: { student: 0, admin: 1 }

  validates :university, presence: true, unless: :admin?
  attr_readonly :university_id
end
