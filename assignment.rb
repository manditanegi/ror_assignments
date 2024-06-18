

def calculate_rgp(units, phase)
  energy_charges = 0
  fixed_charges = 0
  if units > 0
    if units <= 50
      energy_charges += (units * 3.20)
    else
      energy_charges += (50 * 3.20)
      units -= 50

      if units <= 150
        energy_charges += (units * 3.95)
      else
        energy_charges += (150 * 3.95)
        units -= 150
        energy_charges += (units * 5.00)
      end
    end
  end
  fixed_charges = phase == 'SINGLE' ? 25 : 65
  total_bill = (energy_charges + fixed_charges) * 30
  puts "Your RGP bill is: Rs. #{total_bill}"
end

def calculate_bpl(units)
  energy_charges = 0
  fixed_charges = 5
  if units > 0
    if units <= 50
      energy_charges += units * 1.50
    else
      energy_charges += 50 * 1.50
      units -= 50

      if units <= 150
        energy_charges += units * 3.95
      else
        energy_charges += 150 * 3.95
        units -= 150
        energy_charges += units * 5.00
      end
    end
  end
  total_bill = (energy_charges + fixed_charges) * 30
  puts "Your BPL bill is: Rs. #{total_bill}"
end

def calculate_glp(units, phase)
  energy_charges = 0
  fixed_charges = 0
  if units > 0
    if units <= 200
      energy_charges += units * 4.10
    else
      energy_charges += 200 * 4.10
      units -= 200
      energy_charges += units * 4.80
    end
  end
  fixed_charges = phase == "SINGLE" ? 30 : 70
  total_bill = (energy_charges + fixed_charges) * 30
  puts "Your GLP bill is: Rs. #{total_bill}"
end

def calculate_non_rgp(units, units_kw)
  energy_charges = units * 4.60
  if units_kw <= 5
    fixed_charges = 70 * units
  elsif units_kw <= 15
    fixed_charges = 90 * units
  else
    fixed_charges = 0
  end

  total_bill = (energy_charges + fixed_charges) * 30
  puts "Your Non-RGP bill is: Rs. #{total_bill}"
end

def validate_tariff_plan(plan,phase='')
  valid_plans = ["RGP","GPL", "NRGP"]
  until valid_plans.include?(plan)
    puts "Invalid input! Please enter a valid tariff plan (RGP, GPL, NRGP):"
    plan = gets.chomp.upcase
  end
  if plan == "RGP"
    puts "Enter your category (RGP, BPL):"
    plan = gets.chomp.upcase
    if plan == "RGP"
      puts "Enter type of Phase (Single, Three):"
      phase = gets.chomp.upcase
    end
  end
  if plan == "GPL"
    puts "Enter type of Phase (Single, Three):"
    phase = gets.chomp.upcase
  end
  {"tariff_plan"=> plan, "phase"=> phase}
end

puts "-- Power Calculator --"
puts "Enter your tariff plan (RGP, GPL, NRGP):"
result = validate_tariff_plan(gets.chomp.upcase)
tariff_plan = result["tariff_plan"]
phase = result["phase"]

puts "Enter units consumed in kW per day:"
units_consumed = gets.chomp.to_f
units_converted = units_consumed.to_f * 24

case tariff_plan
when "RGP", "BPL", "NRGP"
  until units_consumed <= 15
    puts "Invalid input! Units should be <= 15 kW for #{tariff_plan} tariff plan."
    puts "Enter units consumed in kW again:"
    units_consumed = gets.chomp.to_f
  end
end

case tariff_plan
when "RGP"
  calculate_rgp(units_converted, phase)
when "BPL"
  calculate_bpl(units_converted)
when "GPL"
  calculate_glp(units_converted, phase)
when "NRGP"
  calculate_non_rgp(units_converted, units_consumed)
end
