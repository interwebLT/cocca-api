class Audit::Contact < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_contact

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  alias_attribute :partner, :clid

  def as_json options = nil
    {
      handle:             self.id,
      name:               self.intpostalname,
      organization:       self.intpostalorg,
      street:             self.intpostalstreet1,
      street2:            self.intpostalstreet2,
      street3:            self.intpostalstreet3,
      city:               self.intpostalcity,
      state:              self.intpostalsp,
      postal_code:        self.intpostalpc,
      country_code:       self.intpostalcc,
      local_name:         self.locpostalname,
      local_organization: self.locpostalorg,
      local_street:       self.locpostalstreet1,
      local_street2:      self.locpostalstreet2,
      local_street3:      self.locpostalstreet3,
      local_city:         self.locpostalcity,
      local_state:        self.locpostalsp,
      local_postal_code:  self.locpostalpc,
      local_country_code: self.locpostalcc,
      voice:              self.voice,
      voice_ext:          self.voicex,
      fax:                self.fax,
      fax_ext:            self.faxx,
      email:              self.email
    }
  end
end
