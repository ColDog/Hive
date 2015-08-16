module Validators
  class InactiveOnValidator < ActiveModel::Validator
    def validate(record)
      if record.current && record.inactive_on.present?
        record.errors[:base] << 'Currently active should not be checked if a date for inactive on is chosen.'
      elsif record.current == false && record.inactive_on.present? == false
        record.errors[:base] << 'If current is not checked, you should select a date.'
      end
    end
  end
end