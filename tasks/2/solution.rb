class Hash
  def fetch_deep(input)
  	key, nested_key_path = input.split('.', 2)
    value = self[key.to_sym] || self[key.to_s]

    return value unless nested_key_path
    	
    value.fetch_deep(nested_key_path) if value
  end

  def reshape(shape)
    shape.keys.map do |key|
    	if shape[key].class != Hash
    	  [key, fetch_deep(shape[key])]
    	else
    	  [key, reshape(shape[key])]
    	end
    end.to_h
  end
end

class Array
  def reshape(shape)
  	map! { |x| x.reshape(shape)}
  end
end