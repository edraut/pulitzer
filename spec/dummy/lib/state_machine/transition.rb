module StateMachine
  module Transition
    def self.included(klass)
      klass.extend ActiveModel::Naming
      klass.extend ClassMethods
      klass.class_attribute :action_name, :target_state
    end

    attr_accessor :errors, :object

    delegate :action_name, :target_state, :valid_from_states, :status_field, to: :class

    module ClassMethods
      def status_field=(field_name)
        @status_field = field_name
      end

      def status_field
        return @status_field if @status_field
        return 'status' if self.transitioning_class.column_names.include? 'status'
        return 'state' if self.transitioning_class.column_names.include? 'state'
      end

      def valid_from_states=(array)
        if array.first.respond_to? :to_sym
          @valid_from_states = array.map(&:to_sym)
        else
          @valid_from_states = array
        end
      end

      def valid_from_states
        @valid_from_states
      end

      def transitioning_class
        self.name.deconstantize.constantize
      end
    end

    def current_state
      current_state = self.object.send status_field
      current_state = current_state.to_sym if current_state.respond_to? :to_sym
      current_state
    end

    def validate_transition
      if self.valid_from_states.exclude? self.current_state
        self.errors.add(:base, "You can't transition from #{self.current_state} to #{self.target_state}")
        self.object.errors.add(:base, "You can't transition from #{self.current_state} to #{self.target_state}")
      end
    end

    def validate_transition!
      if self.valid_from_states.exclude? self.current_state
        raise "You can't transition from #{self.current_state} to #{self.target_state} for #{self.object.class.name} #{self.object.id}"
      end
    end

    def update_status
      self.object.update status_field => self.target_state
    end

  end
end