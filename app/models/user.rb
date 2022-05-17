class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :set_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, foreign_key: 'user_id'
  has_many :foods, foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  # private

  def set_role
    update(role: 'user')
  end
end
