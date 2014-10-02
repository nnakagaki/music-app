class Track < ActiveRecord::Base
  validates :name, :album, :lyrics, :track_type, presence: true
  validates :name, uniqueness: { scope: :album }

  belongs_to :album, inverse_of: :tracks
  has_one :band, through: :album, source: :band
  has_many :notes, inverse_of: :track, dependent: :destroy

end
