class ProductImage < Asset
  has_attached_file :attachment, :styles => { :thumbnail => "64x64>", profile: "300x300>" },
    :convert_options => {:thumbnail => "-gravity center -extent 64x64", :profile => "-gravity center -extent 300x300"}
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
