# 2 classes for voter and politician each, one for main menu and one to manage arrayofppl
#and it's methods. 13 methods and a lot of
# ifs and thens later it eventually worked but feels like I overcomplicated it.

class Voter
  attr_accessor :name, :politics
  def initialize(name, politics)
    @name = name
    @politics = politics
  end
  def get_info
    @output = "Voter, #{@name}, #{@politics}"
  end
end

class Politician
  attr_accessor :name, :party, :votes
  def initialize(name, party)
    @name = name
    @party = party
    @votes = 0
  end
  def get_info
    @output = "Politician, #{@name}, #{@party}"
  end
end


class Arraymgmt
    attr_accessor :voters, :politicians, :votes
    def initialize
      @voters = []
      @politicians = []
      @votes = {}
    end

    def create_politician(name, party)
      politician = Politician.new(name, party)
      @politicians << politician
      puts
      puts "Created Politician : #{politician.name} (#{politician.party})"
      puts
    end

    def create_voter(name, politics)
      voter = Voter.new(name, politics)
      @voters << voter
      puts
      puts "Created Voter : #{voter.name} (#{voter.politics})"
    end

    def delete_voter_entry(voter_object)
      # @voters.delete_if{|voter|voter.name==name}
      @voters.delete(voter_object) if @voters.include?(voter_object)
      puts "Deleted Voter"
    end
    def delete_politician_entry(politician_object)
      @politicians.delete(politician_object) if @politicians.include?(politician_object)
      puts "Deleted Politician"
    end
    def update_name(name, update_name_to)
      person = find(name)
      person.name = update_name_to
    end
    def update_party(name, update_party_to)
      person = find(name)
      person.party = update_party_to
    end
    def update_politics(name, update_politics_to)
      person = find(name)
      person.politics = update_politics_to
    end
    def print_list(list)
      list.each do |person|
        puts person.get_info
      end
    end
    def list(type)
      if type == "p"
        print_list(@politicians)
      elsif type == "v"
        print_list(@voters)
      else
        print_list(@politicians)
        print_list(@voters)
      end
   end
    def find(name)
      @politicians.each do |politician|
        return politician if politician.name.downcase == name.downcase
      end
      @voters.each do |voter|
        return voter if voter.name.downcase == name.downcase
      end
      return false
    end
end

class Votersim
  attr_reader :world
  def initialize(world)
    @world = world
  end

  def main_menu
    input_clud = get_answer("Hey, welcome to the voter simulator! What would you like to do?", "(C)reate, (L)ist, (U)pdate, (D)elete",["c", "l", "u", "d",])
    case input_clud
    when "c"
      input_pv = get_answer("What would you like to create?", "(P)olitician or (V)oter", ["p", "v"])
      print "Enter name: "
      name = gets.chomp
      if input_pv == "p"
        party = get_answer("What is your party?", "(D)emocrat or (R)epublican", ["d", "r"])
        world.create_politician(name, party)
        return false
      else
        politics = get_answer("What are your politics? ", "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral", ["l", "c", "t", "s", "n"])
        world.create_voter(name, politics)
        return false
      end
    when "l"
      puts "Here is your requested list:"
      world.list("")
      return false
    when "u"
      type = get_answer("Who would you like to update?", "(P)oliticians or (V)oters",["v", "p"])
      world.list(type)
      print "Enter name: "
      name = gets.chomp
      person = world.find(name)
      if person.is_a? Politician
        update_politician = get_answer("What are we changing today?", "(N)ame or (P)arty", ["n", "p"])
        if update_politician == "p"
          update_party_to = get_answer("What party would you like to change to?", "(R)epublican or (D)emocrat", ["r", "d"])
          world.update_party(name, update_party_to)
        elsif update_politician == "n"
          print "What is their new name: "
          update_name_to = gets.chomp.downcase
          world.update_name(name, update_name_to)
        end
        elsif person.is_a? Voter
        update_voter = get_answer("What would you like to change?", "(N)ame or (P)olitics", ["n", "p"])
        if update_voter == politics
          update_politics_to = get_answer("What politics would you like to change to?", "(T)ea Party, (C)onservative, (N)eutral, (L)iberal, or (S)ocialist ", ["t", "c", "n", "l", "s"])
          world.update_politics(name)
        elsif update_voter == name
         print "What is their new name: "
         update_name_to = gets.chomp.downcase
         world.update_name(name, update_politics_to)
        end
        else
        puts "This person does not exist in our database."
        return false
      end
      return false
    when "d"
        print "Whose name would you like to delete?"
        name = gets.chomp
        person = world.find(name)
        if person.is_a? Politician
          world.delete_politician_entry(person)
          puts "^_^ The entry has been permanently deleted!"
          puts "="*10
        elsif person.is_a? Voter
          world.delete_voter_entry(person)
          puts "^_^ The entry has been permanently deleted!"
          puts "="*10
        else
          puts "Sorry this person does not exist in our database"
          puts "="*10
        end
        return false
    end
  end

  def get_answer(prompt, choice, valid)
    is_valid = false
    while !is_valid do
      puts prompt
      print choice + " :"
      answer = gets.chomp.downcase
      is_valid = true if valid.include? answer
      puts "Please enter a menu selection " if !is_valid
    end
    return answer
  end
end

arrayofppl = Arraymgmt.new
votersimmain = Votersim.new(arrayofppl)
until votersimmain.main_menu
end
