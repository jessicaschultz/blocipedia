class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

         # validates :name, presence: true

  has_many :wikis, dependent: :destroy
  has_many :collaborators

  #role: [:standard => 0 (which is default), :premium => 1, :admin => 3]
  enum role: [:standard, :premium, :admin]
end
