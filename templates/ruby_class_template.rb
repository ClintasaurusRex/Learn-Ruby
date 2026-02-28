# frozen_string_literal: true

# =============================================================================
# ruby_class_template.rb
#
# Full OOP class template with:
#   - Constants
#   - attr_accessor with types
#   - initialize with validation
#   - Instance and class methods
#   - Comparable included
#   - Subclass example
#   - to_s and inspect overrides
# =============================================================================

# -----------------------------------------------------------------------------
# Main class
# -----------------------------------------------------------------------------
class Vehicle
  include Comparable

  # Constants
  MAX_SPEED_KMH = 300
  VALID_TYPES    = %w[sedan suv truck motorcycle].freeze

  # Attribute readers (public)
  attr_reader :make, :model, :year, :type

  # Attribute accessor (readable and writable)
  attr_accessor :color

  # Class-level data
  @total_created = 0

  class << self
    attr_reader :total_created

    def create(make:, model:, year:, type: "sedan", color: "white")
      new(make: make, model: model, year: year, type: type, color: color)
    end
  end

  # ---------------------------------------------------------------------------
  # Constructor with validation
  # ---------------------------------------------------------------------------
  def initialize(make:, model:, year:, type: "sedan", color: "white")
    validate_year!(year)
    validate_type!(type)

    @make     = make.to_s.strip
    @model    = model.to_s.strip
    @year     = year.to_i
    @type     = type.to_s.downcase
    @color    = color.to_s
    @mileage  = 0

    self.class.instance_variable_set(
      :@total_created,
      (self.class.total_created || 0) + 1
    )
  end

  # ---------------------------------------------------------------------------
  # Instance methods
  # ---------------------------------------------------------------------------
  def drive(km)
    raise ArgumentError, "Distance must be positive" unless km.positive?

    @mileage += km
    "#{full_name} drove #{km} km. Total: #{@mileage} km."
  end

  def mileage
    @mileage
  end

  def age
    Time.now.year - @year
  end

  def full_name
    "#{@year} #{@make} #{@model}"
  end

  def to_s
    "#{full_name} (#{@color} #{@type})"
  end

  def inspect
    "#<#{self.class.name} make=#{@make.inspect} model=#{@model.inspect} " \
      "year=#{@year} color=#{@color.inspect} mileage=#{@mileage}>"
  end

  # ---------------------------------------------------------------------------
  # Comparable — sort vehicles by year (newest first when reversed)
  # ---------------------------------------------------------------------------
  def <=>(other)
    year <=> other.year
  end

  private

  def validate_year!(year)
    current_year = Time.now.year
    unless year.to_i.between?(1886, current_year + 2)
      raise ArgumentError, "Year must be between 1886 and #{current_year + 2}"
    end
  end

  def validate_type!(type)
    unless VALID_TYPES.include?(type.to_s.downcase)
      raise ArgumentError, "Type must be one of: #{VALID_TYPES.join(', ')}"
    end
  end
end

# -----------------------------------------------------------------------------
# Subclass example
# -----------------------------------------------------------------------------
class ElectricVehicle < Vehicle
  VALID_TYPES = %w[sedan suv truck].freeze  # EVs have fewer types

  attr_reader :battery_kwh, :range_km

  def initialize(battery_kwh:, range_km:, **kwargs)
    # Pass all parent keyword args up
    super(**kwargs.merge(type: kwargs.fetch(:type, "sedan")))
    @battery_kwh = battery_kwh.to_f
    @range_km    = range_km.to_f
    @charge      = 100.0  # percent
  end

  def charge_level
    "#{@charge.round(1)}%"
  end

  def charge!(amount = 100)
    @charge = [@charge + amount, 100.0].min
    "Charged to #{charge_level}"
  end

  def drive(km)
    range_check!(km)
    result = super
    @charge -= (km.to_f / @range_km * 100).round(2)
    result
  end

  def to_s
    "#{super} [EV, #{@battery_kwh}kWh, #{@range_km}km range]"
  end

  private

  def range_check!(km)
    available_km = @range_km * (@charge / 100.0)
    if km > available_km
      raise "Insufficient charge. Available range: #{available_km.round(1)} km"
    end
  end
end

# -----------------------------------------------------------------------------
# Example usage (runs when file is executed directly)
# -----------------------------------------------------------------------------
if __FILE__ == $PROGRAM_NAME
  # Create vehicles
  car = Vehicle.create(make: "Toyota", model: "Camry", year: 2022, color: "blue")
  ev  = ElectricVehicle.new(
    make: "Tesla", model: "Model 3", year: 2023,
    battery_kwh: 75, range_km: 500
  )

  puts car
  puts ev
  puts car.drive(150)
  puts ev.drive(100)

  # Comparable
  vehicles = [
    Vehicle.create(make: "Honda", model: "Civic", year: 2019),
    Vehicle.create(make: "Ford",  model: "F-150", year: 2021, type: "truck"),
    car
  ]

  puts "\nSorted by year:"
  vehicles.sort.each { |v| puts "  #{v.full_name}" }

  puts "\nNewest: #{vehicles.max.full_name}"
  puts "Oldest: #{vehicles.min.full_name}"

  puts "\nTotal vehicles created: #{Vehicle.total_created}"
end
