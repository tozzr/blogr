class Slugr
  def self.exec s = ""
    s = s.nil? ? "" : s
    s.downcase
       .gsub(/ *- */, '-')
       .gsub(/ /, '-')
  end
end
