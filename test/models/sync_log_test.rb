require 'test_helper'

describe SyncLog do
  describe :last_run do
    context :when_multiple_runs do
      subject { SyncLog.last_run }

      before do
        SyncLog.create since: '2015-01-06 2:57 PM'.to_time, until: '2015-01-06 2:58 PM'.to_time
        SyncLog.create since: '2015-01-06 2:58 PM'.to_time, until: '2015-01-06 2:59 PM'.to_time
        SyncLog.create since: '2015-01-06 2:59 PM'.to_time, until: '2015-01-06 3:00 PM'.to_time
      end

      specify { subject.must_equal '2015-01-06 3:00 PM'.to_time }
    end

    context :when_first_run do
      let(:current_time) { Time.now }

      specify { SyncLog.last_run(current_time: current_time).must_equal current_time }
    end
  end
end
