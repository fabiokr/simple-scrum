# == Schema Information
#
# Table name: stories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  color       :string(255)
#  description :text
#  estimative  :integer
#  priority    :integer
#  product_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  creator_id  :integer
#  updater_id  :integer
#

class Story < ActiveRecord::Base
  stampable

  before_save :set_default_status

  belongs_to :product
  belongs_to :sprint

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..200

  validates_numericality_of :estimative
  validates_numericality_of :priority

  STATUS = [
    TODO = 1,
    DOING = 2,
    DONE = 3
  ].freeze

  STATUS_STR = {
    TODO => "todo",
    DOING => "doing",
    DONE => "done"
  }.freeze

  def status_str
    STATUS_STR[self.status]
  end

  def self.per_page
    15
  end

  private

  def set_default_status
    self.status = TODO if self.status.nil?
  end

end

