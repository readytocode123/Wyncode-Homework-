height = ARGV[0].to_i
output = ""
height.times do |i|
  i+=1
  output << "*" * i
  output << "\n"
end
puts output
