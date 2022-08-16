class Post < ApplicationRecord

    validates :title, :content, presence: true

    acts_as_votable 

    scope :free, -> { where(premium: false) }

    def to_s
        title 
    end
end
