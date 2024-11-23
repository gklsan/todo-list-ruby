require_relative 'todo_list'
require_relative 'task'

class TodoApp
  DATA_FILE = File.join(File.dirname(__FILE__), '../data/tasks.json')
  
  def initialize
    @todo_list = TodoList.new
    @todo_list.load_from_file(DATA_FILE)
  end
  
  def run
    loop do
      display_menu
      choice = gets.chomp
      
      case choice
      when '1' then add_task
      when '2' then list_tasks
      when '3' then toggle_task
      when '4' then remove_task
      when '5' then break
      else
        puts "Invalid option. Please try again."
      end
      
      @todo_list.save_to_file(DATA_FILE)
    end
    
    puts "Goodbye!"
  end
  
  private
  
  def display_menu
    puts "\n=== Todo List Application ==="
    puts "1. Add new task"
    puts "2. List tasks"
    puts "3. Toggle task completion"
    puts "4. Remove task"
    puts "5. Exit"
    print "\nChoose an option: "
  end
  
  def add_task
    print "Enter task title: "
    title = gets.chomp
    task = @todo_list.add_task(title)
    puts "Task added with ID: #{task.id}"
  end
  
  def list_tasks
    tasks = @todo_list.all_tasks
    
    if tasks.empty?
      puts "No tasks found."
      return
    end
    
    puts "\nAll Tasks:"
    tasks.each do |task|
      status = task.completed ? "[X]" : "[ ]"
      puts "#{task.id}: #{status} #{task.title}"
    end
  end
  
  def toggle_task
    list_tasks
    print "\nEnter task ID to toggle: "
    id = gets.chomp
    
    if @todo_list.toggle_task(id)
      puts "Task status toggled successfully!"
    else
      puts "Task not found."
    end
  end
  
  def remove_task
    list_tasks
    print "\nEnter task ID to remove: "
    id = gets.chomp
    
    if @todo_list.remove_task(id)
      puts "Task removed successfully!"
    else
      puts "Task not found."
    end
  end
end

# Start the application
if __FILE__ == $0
  TodoApp.new.run
end
