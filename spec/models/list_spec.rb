require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks as from the list as complete' do  
      list = List.create(name: "my fav thangs")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)

      list.complete_all_tasks! 

      list.tasks.each do |task| 
        expect(task.complete).to eq(true)
      end 
    end 
  end 

  describe '#snooze_all_tasks!' do 
    it 'should add an hour to the task deadline' do 
      list = List.create(name: 'blah blah') 
      time = Time.now 
      tasks = Task.create(deadline: time, list_id: list.id) 

      list.snooze_all_tasks!

      list.tasks.each do |task| 
        expect(task.deadline).to eq(time + 1.hour)
      end 
    end 
  end 

  describe '#total_duration' do 
    it 'should return an integer representing total minutes of all tasks' do 
      list = List.create(name: 'blah') 
      Task.create(duration: 20, list_id: list.id) 
      Task.create(duration: 30, list_id: list.id)
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 20, list_id: list.id) 
      Task.create(duration: 30, list_id: list.id)
      Task.create(duration: 50, list_id: list.id) 

      list.total_duration 

      expect(list.total_duration).to eq (200)
    end 
  end 

  describe '#incomplete_tasks' do 
    it 'should return an integer representing tasks that have the status of false for complete' do 
      list = List.create(name: 'bleh') 
      Task.create(complete: false, list_id: list.id) 
      Task.create(complete: false, list_id: list.id) 
      Task.create(complete: true, list_id: list.id) 
      Task.create(complete: false, list_id: list.id) 
      Task.create(complete: false, list_id: list.id) 
      Task.create(complete: true, list_id: list.id) 

      incomplete_tasks = [] 

      list.tasks.each do |task| 
        if task.complete == false 
          incomplete_tasks << task 
        end 
      end
      expect(incomplete_tasks.length).to eq(4) 
    end 
  end 

  describe '#favorite_tasks' do 
    it 'should return a list of tasks that have the status of favorites as true' do 
      list = List.create(name: 'bleh') 
      Task.create(favorite: true, list_id: list.id) 
      Task.create(favorite: true, list_id: list.id) 
      Task.create(favorite: true, list_id: list.id) 

      favorite_tasks = [] 

      list.tasks.each do |task| 
        if task.favorite
          favorite_tasks << task 
        end 
      end

      expect(favorite_tasks.length).to eq(3) 
    end 
  end 
end
