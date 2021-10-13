class Article < ActiveRecord::Base
  # One article can have many comments.
  # @article.comments
  # if an article is deleted, its associated comments will also need to be deleted
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
end
