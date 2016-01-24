module Pulitzer
  class ContentElementValidator < ActiveModel::Validator
    attr_accessor :record

    def validate(record)
      self.record = record
      validate_label_presence
      validate_lable_uniqueness if record.ensure_unique
    end

    private

      def validate_label_presence
        record.errors.add(:label, "is required.") unless record.label.present?
      end

      def validate_label_uniqueness
        if record.version && record.version.content_elements.to_a.reject{|ce| ce == record}.any?{|ce| ce.label == record.label}
          record.errors.add(:label, "is already taken.")
        end
      end

  end
end