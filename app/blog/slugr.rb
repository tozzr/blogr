module Blog
  class Slugr
    def self.exec s = ""
      s = s.nil? ? "" : s
      s.downcase
         .gsub(/ *- */, '-')
         .gsub(/ /, '-')
         .gsub(/ä/, 'ae')
         .gsub(/ö/, 'oe')
         .gsub(/ü/, 'ue')
         .gsub(/ß/, 'ss')
         .gsub(/[^a-zA-Z0-9-]+/, '')
    end
  end
end
