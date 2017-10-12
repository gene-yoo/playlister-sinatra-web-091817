class Genre < ActiveRecord::Base
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs
  has_many :song_genres

  def slug
    slugged = self.name.downcase.gsub("$","s")
    slugged.gsub!(/[!@%&"']/,'')
    slugged.gsub!(/ /,'-')
    slugged
  end

  def self.find_by_slug(slugged_name)
    self.all.find do |genre|
      genre.slug == slugged_name
    end
  end
end
