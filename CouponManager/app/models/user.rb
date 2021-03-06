# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/:style/missing.png', storage: :cloudinary,
                             path: ':id/:style/:filename'
  # :path => ":rails_root/public/controllers/:style/:basename.:extension",
  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\z}

  acts_as_tenant(:organization)
end
