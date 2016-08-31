require 'bundler/setup'
require 'chronic'
require 'colorize'
require 'date'
require 'formatador'
require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"

list = UdaciList.new(title: "Julia's Stuff")
list.add_item("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
list.add_item("todo", "Sweep floors", due: "2016-01-30")
list.add_item("todo", "Buy groceries", priority: "high")
list.add_item("event", "Birthday Party", start_date: "2016-05-08")
list.add_item("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
list.add_item("link", "https://github.com", site_name: "GitHub Homepage")
list.print_all_items
list.delete_item(3)
list.print_all_items

# SHOULD CREATE AN UNTITLED LIST AND add_item ITEMS TO IT
# --------------------------------------------------
 new_list = UdaciList.new # Should create a list called "Untitled List"
 new_list.add_item("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
 new_list.add_item("todo", "Go dancing", due: "in 2 hours")
 new_list.add_item("todo", "Buy groceries", priority: "high")
 new_list.add_item("event", "Birthday Party", start_date: "May 31")
 new_list.add_item("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
 new_list.add_item("event", "Life happens")
 new_list.add_item("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
 new_list.add_item("link", "http://ruby-doc.org")

# SHOULD RETURN ERROR MESSAGES
# ----------------------------
 #new_list.add_item("image", "http://ruby-doc.org") # Throws InvalidItemType error
 #new_list.delete_item(9) # Throws an IndexExceedsListSize error
 #new_list.add_item("todo", "Hack some portals", priority: "super high") # throws an InvalidPriorityValue error

# DISPLAY UNTITLED LIST
# ---------------------
 new_list.print_all_items


# DEMO FILTER BY ITEM TYPE
# ------------------------
new_list.filter("event")

# GET TASKDUE WITHIN THE NEXT DAYS
new_list.items_due_within_next_no_of_days(3)
new_list.items_due_within_next_no_of_days(40)
new_list.print_items_in_table_format
