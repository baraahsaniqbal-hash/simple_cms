class Page < ApplicationRecord

  #has_and_belongs_to_many :editors, :class_name => "AdminUser", dependent: :destroy

  belongs_to :subject
  has_many :sections, dependent: :destroy
  
  acts_as_list scope: :subject

  before_validation :add_default_permalink
  after_save :touch_subject
  after_validation :log_errors_if_any
  before_update :prevent_home_permalink_change
  after_save :notify_save_success

  #validates :editors, length: { minimum: 1, message: "must have at least one editor assigned" }
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink
  # for unique values by subject use ":scope => :subject_id"
  
  #belongs_to :subject, optional: true
  #validates :subject, absence: true
  # validates :name, uniqueness: { scope: :permalink,
  #   message: "should be unique for permalink" }
  # validates :permalink, inclusion: { in: %w(first second third),
  #   message: "%{value} is not a valid permalink" }
  # validates :permalink, exclusion: { in: %w(one two three),
  #   message: "%{value} is reserved." }
  
  scope :visible, lambda { where(:visible => true)} #standard lambda
  scope :invisible, -> { where(:visible => false)} #stabby lambda
  scope :sorted, lambda{ order("position ASC")}
  scope :newest_first, lambda{ order("pages.created_at DESC")}
  scope :search, lambda{ |query|
    where(["name LIKE ?", "%#{query}%"])
  }
  scope :recent, lambda{ where(:created_at => 1.week.ago..Time.now)}

  private
    def add_default_permalink
      if permalink.blank?
        self.permalink = "#{position}-#{name.parameterize}"
      end
    end

    def touch_subject
      #touch the associated subject, updating its updated_at timestamp
      subject.touch
    end

    def log_errors_if_any
      puts "Validation failed: #{errors.full_messages}" if errors.any?
    end

    def prevent_home_permalink_change
      if permalink_was == "home" && permalink_changed?
        errors.add(:permalink, "Cannot change the home page link.")
        throw(:abort) # Stops the update from saving
      end
    end

    def notify_save_success
      puts "Page successfully saved to the database!"
    end
end
