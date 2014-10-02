class Album < ActiveRecord::Base
  validates :name, :band, :album_type, presence: true
  validates :name, uniqueness: { scope: :band }

  belongs_to :band, inverse_of: :albums
  has_many :tracks, inverse_of: :album, dependent: :destroy
  has_one :user, through: :band, source: :user

end
