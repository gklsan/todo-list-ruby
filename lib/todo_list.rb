require 'json'
require_relative 'task'

class TodoList
  def initialize
    @tasks = []
  end
  
  def add_task(title)
    task = Task.new(title)
    @tasks << task
    task
  end
  
  def remove_task(id)
    @tasks.reject! { |task| task.id == id }
  end
  
  def toggle_task(id)
    task = find_task(id)
    task&.toggle_completion
  end
  
  def all_tasks
    @tasks
  end
  
  def pending_tasks
    @tasks.reject(&:completed)
  end
  
  def completed_tasks
    @tasks.select(&:completed)
  end
  
  def save_to_file(filename)
    File.write(filename, JSON.pretty_generate(@tasks.map(&:to_json)))
  end
  
  def load_from_file(filename)
    return unless File.exist?(filename)
    
    json_data = File.read(filename)
    json_tasks = JSON.parse("[#{json_data.split("\n").join(",")}]")
    @tasks = json_tasks.map { |task_json| Task.from_json(task_json) }
  end
  
  private
  
  def find_task(id)
    @tasks.find { |task| task.id == id }
  end
end
