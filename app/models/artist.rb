class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    slugged = self.name.downcase.gsub("$","s")
    slugged.gsub!(/[!@%&"']/,'')
    slugged.gsub!(/ /,'-')
    slugged
  end

  def self.find_by_slug(slugged_name)
    self.all.find do |artist|
      artist.slug == slugged_name
    end
  end
end
