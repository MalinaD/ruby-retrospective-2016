MELTING_POINT = {'water' => 0, 'ethanol' => -114, 'gold' => 1_064, 'silver' => 961.8, 'copper' => 1_085}

BOILING_POINT = {'water' => 100, 'ethanol' => 78.37, 'gold' => 2_700, 'silver' => 2_162, 'copper' => 2_567}

def convert_between_temperature_units(degree, unit_degree, unit_result)
  if unit_degree == unit_result
    degree
  else
    convert_to_c_from = { 'K' => degree - 273.15, 'F' => (degree - 32) / 1.8, 'C' => degree }
    convert_to = {
      'C' => convert_to_c_from[unit_degree],
      'F' => convert_to_c_from[unit_degree] * 1.8 + 32,
      'K' => convert_to_c_from[unit_degree] + 273.15
    }
    convert_to[unit_result]
  end
end

def melting_point_of_substance(substance, unit_degree)
  convert_between_temperature_units(MELTING_POINT[substance], 'C', unit_degree)
end

def boiling_point_of_substance(substance, unit_degree)
  convert_between_temperature_units(BOILING_POINT[substance], 'C', unit_degree)
end