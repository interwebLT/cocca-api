class String
  def xml
    File.read("spec/assets/#{self}.xml").strip
  end

  def epp
    EPP::Response.new self.xml
  end

  def json
    JSON.parse File.read("spec/assets/#{self}.json").strip, symbolize_names: true
  end
end
