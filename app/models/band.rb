class Band < ActiveRecord::Base
  validates :name, :user, presence: true
  validates :name, uniqueness: true

  has_many :albums, inverse_of: :band, dependent: :destroy
  has_many :tracks, through: :albums, source: :tracks
  belongs_to :user, inverse_of: :bands

end
