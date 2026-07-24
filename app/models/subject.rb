class Subject < ApplicationRecord

  # belongs_to :user
  acts_as_list

  # has_many :pages, dependent: :destroy
  has_and_belongs_to_many :universities, after_add: :increment_university_counter,
                          after_remove: :decrement_university_counter

  has_and_belongs_to_many :users

  after_update :log_visibility_change

  #absence
  #validates :name, :absence => true, if: :position?
  #acceptance
  #validates :visible, acceptance: { message: "must be visible" }
  #validates :visible, acceptance: { accept: ["yes",1, true] }
  #comparison
  #validates :created_at, comparison: { less_than: :updated_at }
  #numericality
  #  validates :position, numericality: { only_numeric: true}


  # Don't need to validate (in most cases):
  #   ids, foreign keys, timestamps, booleans, counters
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  validates_length_of :name, :maximum => 255
  #   validates_presence_of vs. validates_length_of :minimum => 1
  #   different error messages: "can't be blank" or "is too short"
  #   validates_length_of allows strings with only spaces!

  scope :visible, lambda { where(:visible => true)} #standard lambda
  scope :invisible, -> { where(:visible => false)} #stabby lambda
  scope :sorted, lambda{ order("subjects.position ASC")}
  scope :newest_first, lambda{ order("subjects.created_at DESC")}
  scope :search, lambda{ |query|
    where(["name LIKE ?", "%#{query}%"])
  }
  scope :recent, lambda{ where(:created_at => 1.week.ago..Time.now)}

  private
  def log_visibility_change
    if saved_change_to_visible?
      puts "Subject '#{name}' visibility changed to #{visible}."
    end
  end

  def increment_university_counter(university)
    University.increment_counter(:subjects_count, university.id)
  end

  def decrement_university_counter(university)
    University.decrement_counter(:subjects_count, university.id)
  end
  
end
