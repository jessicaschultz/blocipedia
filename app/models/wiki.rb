class Wiki < ApplicationRecord
  belongs_to :user
  has_many :users, through: :collaborators
  after_initialize :set_private_default
  #add validations for wiki post (making sure there is a title and body).
  #add flash[:notice] to wiki's new view informing user of error.
  validates :title, presence: true
  validates :body, presence: true

  private
  def set_private_default
    self.private = false if self.private.nil?
  end
end
