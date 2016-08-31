

class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
    @supportedTypes = ["todo", "event", "link"]
    @supportedPriority = ["low", "medium", "high"]
  end
  def add(type, description, options={})
    type = type.downcase

    raise UdaciListErrors::InvalidItemType, "Invalid type to add to list" if !(@supportedTypes.include? type)
    raise UdaciListErrors::InvalidPriorityValue, "Invalid priority type" if (options[:priority] && !(@supportedPriority.include? options[:priority]))
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
     puts @items.size
    raise UdaciListErrors::IndexExceedsListSize, "asfs" if index.to_i > @items.size
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    printItems(items: @items)
    #@items.each_with_index do |item, position|
     # puts "#{position + 1}) #{item.details}"
    #end
  end
  def filter(item_filter)
      items_filtered = @items.select{ |e| (e.item_type.downcase == item_filter.downcase) }
      items_filtered.empty? ? (puts "No items with item type: #{item_filter}") : printItems(items: items_filtered, header: "Items with filter: #{item_filter}")
  end
  def printItems(options={})
      puts options[:header] if options[:header]
      if options[:items]
          options[:items].each_with_index do |item, position|
          puts "#{position + 1}) #{item.details}"
        end
      end
  end
  def itemsDueWithinNextOfDays(number_of_days)
      if number_of_days.is_a? Integer
          puts (Date.today + 10).strftime("%D")
          todo_items = @items.select { |e| (e.item_type.downcase == "todo") && e.due &&
              (Chronic.parse(Date.today.strftime("%D")) <= e.due) && (e.due <= Chronic.parse((Date.today + number_of_days).strftime("%D"))) }
          todo_items.empty? ? (puts "No items todo within the next #{number_of_days} days" ) : printItems(items: todo_items, header: "Items due within the next #{number_of_days} days")
      else
          Puts "Enter valid number of days"
      end
  end
  def printItemsInTable
      for item_type in @supportedTypes
          a = Array.new
          puts "#{item_type}"
          for item in @items.select{|e| e.item_type.downcase == item_type}
              h = Hash.new
              for item_instance in item.instance_variables
                  h[item_instance] = item.instance_variable_get(item_instance)
              end
              a << h
          end
          Formatador.display_table(a)
      end
  end
end
