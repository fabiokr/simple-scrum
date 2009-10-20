require 'user_stampable'

ActiveRecord::Base.class_eval do
  include Userstamp::Stampable
end

