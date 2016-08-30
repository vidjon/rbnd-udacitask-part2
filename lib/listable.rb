module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_date(type, options={})
      type = type.downcase
    if type == "event"
        dates = options[:start_date].strftime("%D") if options[:start_date]
        dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
        dates = "N/A" if !dates
        return dates
    elsif type == "todo"
        options[:end_date] ? options[:end_date].strftime("%D") : "No due date"
    end
  end
  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end
end
