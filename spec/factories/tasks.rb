FactoryBot.define do

   factory :task do
     name { 'task1' }
     description { 'description1' }
     status { 'Completed' }
     deadline { DateTime.now }
     association :user
   end

   factory :second_task, class: Task do
     name { 'task2' }
     description { 'description2' }
     status { 'Not started' }
     deadline { DateTime.tomorrow }
     association :user
   end
end
