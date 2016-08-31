class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :item_type


  def initialize(description, options={})
    @item_type = "ToDo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
  def details
    format_description(@description, @item_type) + "due: " +
    format_date(@item_type, end_date: @due) +
    format_priority(@priority)
  end
end
