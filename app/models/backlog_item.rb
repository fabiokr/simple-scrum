class BacklogItem < ActiveRecord::Base

  belongs_to :backlog
  belongs_to :backlog_item

  validates_presence_of :story
  validates_length_of :story, :in => 1..200

  validates_numericality_of :estimative

end

