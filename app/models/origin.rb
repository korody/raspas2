class Origin < ActiveRecord::Base
  attr_reader :author_tokens, :genre_tokens

  has_many :raspas

  has_many :genrings, dependent: :destroy
  has_many :genres, through: :genrings

  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  has_many :attachments, as: :attachable, dependent: :destroy

  has_many :comments, as: :commentable

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def author_tokens=(tokens)
    self.author_ids = Author.ids_from_tokens(tokens)
  end

  def genre_tokens=(tokens)
    self.genre_ids = Genre.ids_from_tokens(tokens)
  end

end