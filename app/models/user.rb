# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  
  validates :name, presence: true
  validates :email, presence: true
  # if validate password, than during 'sign_out' password will be validated and you'll have validation error
  # validates :password, presence: true
  validates :email, uniqueness: {message: 'Current email already exists, try another'}
  validates :name, uniqueness: {message: 'Current name already exists, try another'}
end
