beatles = [
  {
    name: nil,
    nickname: "The Smart One"
  },
  {
    name: nil,
    nickname: "The Shy One"
  },
  {
    name: nil,
    nickname: "The Cute One"
    },
  {
    name: nil,
    nickname: "The Quiet One"
  }
]

beatles.each do |member|
  
  case member[:nickname]
    when "The Smart One"
      member[:name]="john"
    when "The Shy One"
      member[:name]="ringo"
    when "The Cute One"
      member[:name]="paul"
    when "The Quiet One"
      member[:name]="george"
  end 

end

beatles.each do |member|
  puts "Hi, I'm #{member[:name]}.  I'm #{member[:nickname]}!"
end

# Find nicknames of members: John smart, george quiet one, paul cute one, ringo shy one   
# Replace name hashes with these nicknames using certain methods and procedures. 
# Match their names using case statement 