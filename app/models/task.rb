class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true , length: { in: 1..200 }

  enum priority: [:low, :medium, :high]

  	scope :name_search, -> (query) {where("name LIKE ?", "%#{query}%")}
  	def name_search(query)
  	  where("name LIKE ?", "%#{query}%")
  	end

  	scope :status_search, -> (query) {where(status: query)}
  	def status_search(query)
  	  where(status: query)
  	end
    scope :user_task_list, -> (query) {where(user_id: query)}
    def user_task_list(query)
      where(user_id: query)
    end

    scope :label_search, -> (query) {
		@ids = Labelling.where(label_id: query).pluck(:task_id)
		where(id: @ids)}

  	scope :priority_ordered, -> {order("
  	    CASE tasks.priority
  	    WHEN 'high' THEN 'a'
  	    WHEN 'medium' THEN 'b'
  	    WHEN 'low' THEN 'c'
  	    ELSE 'z'
  	    END ASC,
  	    id DESC" )}
 end
