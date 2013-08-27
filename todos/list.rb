class List
  attr_reader :title, :tasks

  def initialize(title, tasks = [])
    @title = title
    @tasks = tasks
  end

  def add_task(task)

    raise ArgumentError unless task.respond_to?(:complete?)
    raise ArgumentError unless task.respond_to?(:complete!)
    
    tasks << task
  end

  def complete_task(index)
    tasks[index].complete!
  end

  def delete_task(index)
    raise NonExistentTaskError unless tasks[index]
    tasks.delete_at(index)
  end

  def completed_tasks
    tasks.select { |task| task.complete? }
  end

  def incomplete_tasks
    tasks.select { |task| !task.complete? }
  end
end

class NonExistentTaskError < StandardError; end
