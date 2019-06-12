require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should change complete attribute to false if it began as true' do 
      task = Task.create(complete: true) 
      task.toggle_complete!
      expect(task.complete).to eq(false) 
    end  

    it 'should change complete attribute to true if it began as false' do 
      task = Task.create(complete: false)  
      task.toggle_complete!
      expect(task.complete).to eq(true) 
    end 
  end 

  describe '#toggle_favorite!' do 
    it 'should change favorite attribuet to false if it began as true' do 
      task = Task.create(favorite: true) 
      task.toggle_favorite!
      expect(task.favorite).to eq(false) 
    end 

    it 'should change favorite attribuet to true if it began as false' do 
      task = Task.create(favorite: false) 
      task.toggle_favorite!
      expect(task.favorite).to eq(true) 
    end 
  end 

  describe '#overdue?' do 
    it 'should return false if current time is earlier than deadline' do 
      task = Task.create(deadline: Time.now + 10.days)
      expect(task.overdue?).to eq(false) 
    end 

    it 'should return true if current time is later than the deadline' do 
      task = Task.create(deadline: Time.now - 2.days) 
      expect(task.overdue?).to eq(true) 
    end 
  end 

  describe '#increment_priority!' do 
    it 'should increase the priority attribute by one' do 
      task = Task.create(priority: 3)
      task.increment_priority! 
      expect(task.priority).to eq(4) 
    end 

    it 'should not increment priority beyond 10' do 
      task = Task.create(priority:10) 
      task.increment_priority!
      expect(task.priority).to eq(10)
    end 
  end 

  describe '#decrement_priority' do 
    it 'should decrease the priority attribute by one' do 
      task = Task.create(priority: 3) 
      task.decrement_priority! 
      expect(task.priority).to eq(2) 
    end 

    it 'should not decrement priority beyond 1' do 
      task = Task.create(priority:1) 
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end 
  end 

  describe '#snooze_hour!' do 
    it 'should increase the deadline by one hour' do 
      time = Time.now
      task = Task.create(deadline: time) 
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour) 
    end 
  end
end

