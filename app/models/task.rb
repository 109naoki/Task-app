class Task < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def  self.ransack_associations(auth_object = nil)
    []
  end
  validates :name,presence: true,length: {maximum: 30}
  validate :validate_name_not_including_conma
  belongs_to :user
  scope :recent, -> {order(created_at: :desc)}
  private
  def validate_name_not_including_conma
    errors.add(:name,'にカンマを含めることはできません') if name&.include?(',')
  end
end
