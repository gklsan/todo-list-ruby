require 'json'

class Task
  attr_accessor :id, :title, :completed, :created_at
  
  def initialize(title, id: nil, completed: false, created_at: nil)
    @id = id || generate_id
    @title = title
    @completed = completed
    @created_at = created_at || Time.now
  end
  
  def toggle_completion
    @completed = !@completed
  end
  
  def to_json(*_args)
    {
      id: @id,
      title: @title,
      completed: @completed,
      created_at: @created_at.to_s
    }.to_json
  end
  
  def self.from_json(json)
    data = JSON.parse(json, symbolize_names: true)
    new(
      data[:title],
      id: data[:id],
      completed: data[:completed],
      created_at: Time.parse(data[:created_at])
    )
  end
  
  private
  
  def generate_id
    Time.now.to_i.to_s + rand(1000).to_s
  end
end
