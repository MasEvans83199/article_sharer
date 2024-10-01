class Article < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy 
    has_many :votes, as: :votable, dependent: :destroy

    validates :title, presence: true
    validates :link, presence: true
  end
  