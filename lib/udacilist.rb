

class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
    @supportedTypes = ["todo", "event", "link"]
    @supportedPriority = ["low", "medium", "high"]
  end
  def add_item(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemType, "Invalid type to add to list" if !(@supportedTypes.include? type)
    raise UdaciListErrors::InvalidPriorityValue, "Invalid priority type" if (options[:priority] && !(@supportedPriority.include? options[:priority]))
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete_item(index)
    raise UdaciListErrors::IndexExceedsListSize, "Index exceeds the size of the list" if index.to_i > @items.size
    @items.delete_at(index - 1)
  end
  def print_all_items
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    print_items(items: @items)
  end
  def filter(item_filter)
      items_filtered = @items.select{ |item| (item.item_type.downcase == item_filter.downcase) }
      items_filtered.empty? ? (puts "No items with item type: #{item_filter}") : print_items(items: items_filtered, header: "Items with filter: #{item_filter}")
  end
  def print_items(options={})
      puts options[:header] if options[:header]
      if options[:items]
          options[:items].each_with_index do |item, position|
          puts "#{position + 1}) #{item.details}"
        end
      end
  end
  def items_due_within_next_no_of_days(number_of_days)
      if number_of_days.is_a? Integer
          todo_items = @items.select { |item| (item.item_type.downcase == "todo") && item.due &&
              (Chronic.parse(Date.today.strftime("%D")) <= item.due) && (item.due <= Chronic.parse((Date.today + number_of_days).strftime("%D"))) }
          todo_items.empty? ? (puts "No items todo within the next #{number_of_days} days" ) : print_items(items: todo_items, header: "Items due within the next #{number_of_days} days")
      else
          Puts "Enter valid number of days"
      end
  end
  def print_items_in_table_format
      for item_type in @supportedTypes
          items_array = Array.new
          puts "#{item_type}"
          for item in @items.select{|item| item.item_type.downcase == item_type}
              item_hash = Hash.new
              for item_instance in item.instance_variables
                  item_hash[item_instance] = item.instance_variable_get(item_instance)
              end
              items_array << item_hash
          end
          Formatador.display_table(items_array)
      end
  end
end
