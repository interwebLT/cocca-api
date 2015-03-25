require 'test_helper'

describe ContactQuery do
  before do
    create_contact audit_time: audit_time
  end

  let(:since) { '2015-03-06 14:00'.in_time_zone }
  let(:up_to) { '2015-03-06 14:30'.in_time_zone }

  describe :run do
    subject { ContactQuery.run since: since, up_to: up_to, audit_operation: 'I' }

    context :when_record_created_within_period do
      let(:audit_time) { up_to }

      specify { subject.first['partner'].must_equal 'alpha' }
      specify { subject.first['handle'].must_equal 'handle' }

      specify { subject.first['name'].must_equal 'Contact Name' }
      specify { subject.first['organization'].must_equal 'Contact Organization' }
      specify { subject.first['street'].must_equal 'Contact Street' }
      specify { subject.first['street2'].must_equal 'Contact Street 2' }
      specify { subject.first['street3'].must_equal 'Contact Street 3' }
      specify { subject.first['city'].must_equal 'Contact City' }
      specify { subject.first['state'].must_equal 'Contact State' }
      specify { subject.first['postal_code'].must_equal '1234' }
      specify { subject.first['country_code'].must_equal 'PH' }

      specify { subject.first['local_name'].must_equal 'Local Contact Name' }
      specify { subject.first['local_organization'].must_equal 'Local Contact Organization' }
      specify { subject.first['local_street'].must_equal 'Local Contact Street' }
      specify { subject.first['local_street2'].must_equal 'Local Contact Street 2' }
      specify { subject.first['local_street3'].must_equal 'Local Contact Street 3' }
      specify { subject.first['local_city'].must_equal 'Local Contact City' }
      specify { subject.first['local_state'].must_equal 'Local Contact State' }
      specify { subject.first['local_postal_code'].must_equal 'Local 1234' }
      specify { subject.first['local_country_code'].must_equal 'Local PH' }

      specify { subject.first['voice'].must_equal '+63.21234567' }
      specify { subject.first['voice_ext'].must_equal '1234' }
      specify { subject.first['fax'].must_equal '+63.21234567' }
      specify { subject.first['fax_ext'].must_equal '1235' }
      specify { subject.first['email'].must_equal 'test@contact.ph' }
    end

    context :when_record_created_before_period do
      let(:audit_time) { since - 1.day }

      specify { subject.must_be_empty }
    end

    context :when_record_created_after_period do
      let(:audit_time) { since + 1.day }

      specify { subject.must_be_empty }
    end

    context :when_record_created_at_the_end_of_last_period do
      let(:audit_time) { since }

      specify { subject.must_be_empty }
    end
  end
end
