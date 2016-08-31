class LinkItem
  include Listable
  attr_reader :description, :site_name, :item_type


  def initialize(url, options={})
    @item_type = "Link"
    @description = url
    @site_name = options[:site_name]
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    format_description(@description, @item_type) + "site name: " + format_name
  end
end
