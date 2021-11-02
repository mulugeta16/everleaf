FactoryBot.define do
  factory :task do
    name { 'task1' }
    description { 'description1' }
      end
      factory :second_task, class: Task do
      name { 'task2' }
      description { 'description2' }
    end
end
