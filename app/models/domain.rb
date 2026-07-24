class Domain < ApplicationRecord
  belongs_to :university, optional: true

  enum kind: {
    admin: 0,
    university: 1
  }

  validates :host, presence: true, uniqueness: true
  validates :university, presence: true, unless: :admin?
  before_validation :set_kind

  private

  def set_kind
    self.kind ||= :university if university.present?
  end
end
