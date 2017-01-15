def convert_between_temperature_units(degrees, unit_degrees, unit_result)
  if unit_result == 'C' && unit_degrees == 'F'
    ((degrees - 32) / 1.8).round(2)
  elsif unit_result == 'F' && unit_degrees == 'C'
    (degrees * 1.8 + 32).round(2)
  elsif unit_result == 'K' && unit_degrees == 'C'
    (degrees + 273.15).round(2)
  else
    (degrees - 273.15).round(2)
  end
end
def melting_point_of_substance(substance, unit_degrees)
  substances = { water: 0, ethanol: -114, gold: 1064, silver: 961.8, copper: 1085 }
  
  if unit_degrees == 'C'
    substances[substance].to_i
  else
    convert_between_temperature_units(substances[substance].to_i, 'C', unit_degrees)
  end
end
def boiling_point_of_substance(substance, unit_degrees)
  substances = { water: 100, ethanol: 78.37, gold: 2700, silver: 2162, copper: 2567 }
    
  if unit_degrees == 'C'
    substances[substance].to_i
  else
    convert_between_temperature_units(substances[substance].to_i, 'C', unit_degrees)
  end
end