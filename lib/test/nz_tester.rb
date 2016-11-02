class NzTester
	def self.client
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
    client = EPP::Client.new('115', 'F3dc40b2E', 'srstestepp.srs.net.nz', {:ssl_context => context, :extensions => extension, :services => services, :address_family => 'AF_INET'})
    client
  end
end