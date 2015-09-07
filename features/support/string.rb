class String
  def xml
    File.read("features/assets/#{self}.xml").strip
  end

  def epp
    EPP::Response.new self.xml
  end
end
