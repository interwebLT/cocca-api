class String
  def xml
    File.read("features/assets/#{self}.xml").strip
  end
end
