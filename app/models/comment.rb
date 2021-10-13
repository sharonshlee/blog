class Comment < ActiveRecord::Base
  # Each comment belongs to one article.
  belongs_to :article
end
