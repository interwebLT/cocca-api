require 'test_helper'

describe Order do
  subject { Order.new params }

  let(:params) {
    {
      currency_code:  'USD',
      ordered_at: '2016-01-04T15:00:00Z',
      order_details: []
    }
  }

  describe :new do
    specify { subject.currency_code.must_equal 'USD' }
    specify { subject.ordered_at.must_equal '2016-01-04T15:00:00Z' }

    context :when_register_domain do
      let(:params) {
        {
          currency_code:  'USD',
          ordered_at: '2016-01-04T15:30:00Z',
          order_details: [
            {
              type: 'domain_create'
            }
          ]
        }
      }

      specify { subject.order_details.first.must_be_kind_of OrderDetail::RegisterDomain }
    end

    context :when_renew_domain do
      let(:params) {
        {
          currency_code:  'usd',
          ordered_at: '2016-01-04t15:00:00z',
          order_details: [
            {
              type: 'domain_renew'
            }
          ]
        }
      }

      specify { subject.order_details.first.must_be_kind_of OrderDetail::RenewDomain }
    end

    context :when_no_order_details do
      let(:params) {
        {
          currency_code:  'USD',
          ordered_at: '2016-01-04T15:00:00Z'
        }
      }

      specify { subject.order_details.empty?.must_equal true }
    end
  end

  describe :as_json do
    let(:expected_json) {
      {
        id: 1,
        partner:  'partner',
        order_number: 1,
        total_price:  0.00,
        fee:  0.00,
        ordered_at: '2016-01-04T15:00:00Z',
        status: 'pending',
        currency_code:  'USD',
        order_details:  []
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end
