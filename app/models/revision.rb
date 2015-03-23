class Revision < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  validate :different_from_previous_revision

  # default_scope -> { order('created_at ASC') }

  def previous
    if created_at
      page.revisions.where("created_at < ?", created_at).last
    else
      page.revisions.reverse.find { |r| r != self }
    end
  end

  def next
    page.revisions.where("created_at > ?", created_at).first
  end

  def age
    created_at.strftime("%b %e, %l:%M %p")
  end

  def owner
    user || user_ip
  end

  ENGINES = {
    "markdown"  => proc { |content| GitHub::Markdown.render(content) },
    "mediawiki" => proc { |content| WikiCloth::WikiCloth.new(data: content).to_html(noedit: true) },
    "creole"    => proc { |content| Creole.creolize(content) },
    # "redcarpet" => proc { |content| Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content) },
  }

  def to_html
    engine = self.engine || "markdown"
    # p engine: engine
    ENGINES[engine].call(body).html_safe
  end


private
  def different_from_previous_revision
    prev = previous
    if prev and body == prev.body and engine == prev.engine
      errors.add "hasn't been changed"
    end
  end

end
