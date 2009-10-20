module Userstamp
  module Stampable
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods
      def stampable(options = {})
        class_eval do
          belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id', :select => 'id, login, email'

          belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id', :select => 'id, login, email'
        end
      end
    end
  end
end

