class Section < ApplicationRecord

  #has_many :editors, :through => :section_edits, :class_name => "AdminUser", :foreign_key =>"admin_user_id", dependent: :destroy
  #has_many :section_edits, dependent: :destroy
  
  belongs_to :page

  acts_as_list scope: :page
  before_create :set_default_visibility
  after_create :create_initial_log

  CONTENT_TYPES = ['text', 'HTML']

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content
 

  private
    def set_default_visibility
      self.visible = false 
    end

    # def create_initial_log
    #   section_edits.create(summary: "Section created.")
    # end
end
