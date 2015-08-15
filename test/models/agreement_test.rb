require 'test_helper'

class AgreementTest < ActiveSupport::TestCase

  setup do
    @agreement = Agreement.new(organization_id: organizations(:one).id, agreement: sample_file,
                               name: 'Hello', valid_until: Date.today)
  end

  test 'agreement is valid' do
    assert @agreement.valid?, @agreement.errors.full_messages
  end


end
