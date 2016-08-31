module Listable
  def format_description(description, type)
    "Type: #{type}".ljust(12) + "- #{description}".ljust(30)
  end
  def format_date(type, options={})
    if type.downcase == "event"
        dates = options[:start_date].strftime("%D") if options[:start_date]
        dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
        dates = "N/A" if !dates
        return dates
    elsif type.downcase == "todo"
        options[:end_date] ? options[:end_date].strftime("%D") : "No due date"
    end
  end
  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end
end
