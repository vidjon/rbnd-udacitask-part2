class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :item_type

  def initialize(description, options={})
    @item_type = "Event"
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end
  def details
    format_description(@description, @item_type) + "event dates: " + format_date(@item_type,start_date: @start_date, end_date: @end_date)
  end
end
