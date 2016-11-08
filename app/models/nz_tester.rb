class NzTester
	def self.client id='115'
		context = OpenSSL::SSL::SSLContext.new
		context.ca_file = '/home/deploy/ssl/nzrs-root-2012.pem'
		raw = File.read '/home/deploy/ssl/mysrs.pem'
		certificate = OpenSSL::X509::Certificate.new raw
		context.cert = certificate
		keyfile = File.new('/home/deploy/ssl/nz-api.next.mysrs.co.nz.key')
		key = OpenSSL::PKey.read(keyfile)
		context.key = key
		services = ['urn:ietf:params:xml:ns:domain-1.0', 'urn:ietf:params:xml:ns:contact-1.0']
		extension = ['urn:ietf:params:xml:ns:secDNS-1.1']
		client = EPP::Client.new(id, 'F3dc40b2E', 'srstestepp.srs.net.nz', {:ssl_context => context, :extensions => extension, :services => services, :address_family => 'AF_INET'})
		client
	end
	
	def self.check
		client = NzTester.client
		client.check EPP::Domain::Check.new 'test.nz'
	end
	
	def self.contact_params
    {
      postal_info: {
        name: 'Joe Research',
        addr: {
          street: '123 Any Street',
          city: 'Some City',
          sp: 'State',
          pc: '1100',
          cc: 'PH'
        }
      },
      voice:  '+64.95551000',
      fax:  '+64.95551001',
      email:  'joe@someorg.ph',
      auth_info:  { pw: 'ABCDEF1234' }
    }
	end
	
	def self.domain_params registrant_handle
    {
      period: "1y",
      registrant: registrant_handle,
      auth_info:  { pw: 'ABCDEF1234' },
      nameservers: []
    }
  end
end
