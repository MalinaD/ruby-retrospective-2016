class Hash
  def fetch_deep(input)
  	key, nested_key_path = input.split('.', 2)
    value = self[key.to_sym] || self[key.to_s]

    return value unless nested_key_path
    	
    value.fetch_deep(nested_key_path) if value
  end
end