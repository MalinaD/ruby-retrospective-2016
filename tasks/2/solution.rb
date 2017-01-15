class Hash
  def fetch_deep(input)
    hash = {}
    self.each do |key, value|
      hash[key] = value
    end.to_h
+
    new_hash = hash.values.to_s.gsub(/[\[\]\"\\]/, '')
    return nil if new_hash.include?(input)
    new_hash
  end
end