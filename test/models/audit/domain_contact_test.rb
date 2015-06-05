require 'test_helper'

describe Audit::DomainContact do
  describe :admin_contact? do
    specify { admin_domain_contact.admin_contact?.must_equal true }
    specify { billing_domain_contact.admin_contact?.must_equal false }
    specify { tech_domain_contact.admin_contact?.must_equal false }
  end

  describe :billing_contact? do
    specify { billing_domain_contact.billing_contact?.must_equal true }
    specify { admin_domain_contact.billing_contact?.must_equal false }
    specify { tech_domain_contact.billing_contact?.must_equal false }
  end

  describe :tech_contact? do
    specify { tech_domain_contact.tech_contact?.must_equal true }
    specify { admin_domain_contact.tech_contact?.must_equal false }
    specify { billing_domain_contact.tech_contact?.must_equal false }
  end

  private

  def admin_domain_contact
    create :admin_domain_contact
  end

  def billing_domain_contact
    create :billing_domain_contact
  end

  def tech_domain_contact
    create :tech_domain_contact
  end
end
