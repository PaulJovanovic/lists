class Asset < ActiveRecord::Base
  belongs_to :assetable, :polymorphic => true
  delegate :url, :to => :attachment

  def attachment_from_url(url)
    self.attachment = open(url)
  end
end
