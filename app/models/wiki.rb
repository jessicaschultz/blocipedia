class Wiki < ApplicationRecord
  belongs_to :user

  #add validations for wiki post (making sure there is a title and body).
  #add flash[:notice] to wiki's new view informing user of error.
  validates :title, presence: true
  validates :body, presence: true
end
