# Meetups

=begin
  
Create program to construct objects that represent a meetup date. 
  - each object takes a month number (1-12) and a year. 
  - Object should determine the exact date of the meeting in the specified month and year. 
    - determined using string descriptors 
      - 'first', 'second', 'third', 'fourth', 'fifth', 'last', or 'teenth'. 
      - days of the week 'monday', 'tuesday' , etc

Input: 
  - Object instantiation
    - two arguments
    - (year, month) as integers 

  - #day method
    - two arguments
    - (day_of_week, descriptor)   

Output: 
  - Instantiation: 
    - meetup object 

  - #day method
    - Date object 


Rules: 
  - should return nil if requested meetup date doesn't exist
  - calling the #day method should return a Date object with the proper date 
  - strings of day of week and descriptors (first, second, etc) are NOT case sensitive
  - April, June, September, and November have 30 days.
  - February has 28 in most years, but 29 in leap years.
  - All the other months have 31 days.
  - The first day of the week of the month (DOWM) is always between the 1st and 7th of the month.
  - The second DOWM is between the 8th and 14th of the month.
  - The third DOWM is between the 15th and 21st of the month.
  - The fourth DOWM is between the 22nd and 28th of the month.
  - The fifth DOWM is between the 29th and 31st of the month.
  - The last DOWM is between the 22nd and the 31st of the month depending on the number of days in the month.


 E: provided

    - meetup class (year, month)

    - day methodthat takes day of week and descriptor and returns Date object 

D: Date objects 

A: 

    - Define class Meetup 

    - Constructor method
      - two arguments (year, month_number)

    
    - #day instance method
      - two arguments 
        - day of week case insensitive, schedule descriptor case insensitive
      - search range of possible dates to find described day
=end 
    
class Meetup 
  SPECIFIER_DAY_RANGE = {
    'first' => (1..7),
    'second' => (8..14),
    'third' => (15..21),
    'fourth' => (22..28),
    'fifth' => (29..31),
    'last' => (22..31),
    'teenth' => (13..19)
  }

  def initialize(year, month)
    @year = year 
    @month = month 
  end 

  def day(day_of_week, specifier)
    first, last = first_and_last_date_in_range(specifier)
    start_date = create_start_of_range_date_object(first)
    end_date = create_end_of_range_date_object(last)

    start_date.step(end_date) { |date| return date if date.day_of_week}

    


  end 

  def first_and_last_date_in_range(specifier)
    range_array = SPECIFIER_DAY_RANGE[specifier.downcase.strip].to_a
    
    first = range_array.first
    last = range_array.last 

    [first, last]
  end 

  def create_start_of_range_date_object(start_day)
    Date.civil(year, month, start_day)
  end 

  def create_end_of_range_date_object(end_day)
    Date.civil(year, month, end_day)
  end 





end 
