class User < ApplicationRecord
  after_initialize :set_default_role, if: :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  validates :display_name, presence: true, uniqueness: true

  def admin?
    role == "admin"
  end

  private

  def set_default_role
    self.role ||= "user"
  end
end
