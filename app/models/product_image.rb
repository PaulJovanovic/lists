class ProductImage < Asset
  has_attached_file :attachment, :styles => { :thumbnail => "64", profile: "256" }
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
