# ask_food = Proc.new do |input|  
#   system 'clear'
#   puts "Your favorite food is #{input}, correct?" 
# end 

# class SurveySays
#   def repeat_answer(ask) 
#     loop do 
#       system 'clear'
#       puts "What's your favorite food?"
#       answer = gets.chomp.downcase.strip 
#       ask.call(answer)
#       confirm = gets.chomp.downcase.strip 
#       break if confirm.empty? || confirm.match?(/[yY]/)
#     end 
#       system 'clear'
#       puts "Welp.. see ya later!"
#   end 
# end 

# fave_foods = SurveySays.new 
# fave_foods.repeat_answer(ask_food)

def my_method(block)
  str = "I'm inside the method"
  puts str
  block.call
end

str = "I'm a string outside a method"
my_proc = Proc.new { puts str }
my_proc.call
str = "The answer to life is 42."
my_method(my_proc)