module StateMachine
  module Model

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods

      def register_transitions(service_hash)
        service_hash.each do |service_name, service_class|
          define_method("#{service_name}") {
            service_class.new(self)
          }
          define_method("#{service_class.target_state}?") {
            service_class.target_state.to_s == self.send(service_class.status_field)
          }
          delegate service_class.action_name, to: service_name
        end
      end
    end
  end
end