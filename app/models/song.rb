class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :genres, through: :song_genres
  has_many :song_genres

  def slug
    slugged = self.name.downcase.gsub("$","s")
    slugged.gsub!(/[!@%&"']/,'')
    slugged.gsub!(/ /,'-')
    slugged
  end

  def self.find_by_slug(slugged_name)
    self.all.find do |song|
      song.slug == slugged_name
    end
  end
end
