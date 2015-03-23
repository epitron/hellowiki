class Page < ActiveRecord::Base

  has_many :revisions

  validates :title, presence: true

  def latest
    revisions.last || revisions.new
  end

  def history
    revisions.reverse
  end

  def revision=(params)
    revisions.build(params)
  end

  def slugified_title
    title.
      gsub(/\s/, '_').    # spaces to underscores
      gsub(/[!\?:;]/, '')   # remove special characters
  end

  def reslug!
    self.slug = slugified_title
    save!
  end

  before_save :set_slug
  def set_slug
    self.slug = slugified_title unless slug
  end

end
