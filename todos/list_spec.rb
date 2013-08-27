require "rspec"

require_relative "list"

describe List do
  
  let(:title)  { "Ishwar's Mom's Todos" }
  let(:task)  { double('task', complete?: true, complete!: nil) }
  let(:list) { List.new(title) }

  describe '#initialize' do
    it 'takes a title for its first argument' do
      expect(List.new('My todos')).to be_an_instance_of List
    end

    it 'can take a list of todos as an optional argument' do
      expect(List.new(title, ['conquer world', 'become zen'])).to be_an_instance_of List
    end

    it 'requires the title argument' do
      expect { List.new }.to raise_error ArgumentError
    end

  end

  describe '#title' do

  end

  describe '#tasks' do

  end

  describe '#add_task' do

    it 'should include the added task' do
      list.add_task(task)
      expect(list.tasks).to include(task)
    end

    it 'should only allow task-like objects' do
      expect { list.add_task('hello Martine French Girl') }.to raise_error ArgumentError
    end

  end

  describe '#delete_task' do
     
    before do
      list.add_task(task)
      @task_index = list.tasks.index(task)
    end

    it 'should not include the deleted task' do
      list.delete_task(@task_index)
      expect(list.tasks).to_not include(task)
    end

    it 'should not allow deletion of a non existing task' do
      expect { list.delete_task(@task_index + 1000) }.to raise_error NonExistentTaskError
    end


  end

  describe 'scoped listing' do

    before do
      @incomplete_task = double('incomplete task', complete?: false, complete!: nil)
      @complete_task = double('complete task', complete?: true, complete!: nil)
      list.add_task(@incomplete_task)
      list.add_task(@complete_task)
    end
    
    describe '#completed_tasks' do
      
      it 'should include the all the completed tasks' do
        expect(list.completed_tasks).to include(@complete_task)
      end

      it 'should not include the incomplete tasks' do
        expect(list.completed_tasks).to_not include(@incomplete_task)
      end

    end

    describe '#incomplete_tasks' do
      
      it 'should list incomplete_tasks' do
        expect(list.incomplete_tasks).to include(@incomplete_task)
      end

      it 'should not include the complete tasks' do
        expect(list.incomplete_tasks).to_not include(@complete_task)
      end
    end
  end
end
