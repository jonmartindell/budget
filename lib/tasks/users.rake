namespace :users do
  desc "Create the 2 users"
  task :create => :environment do
    STDOUT.puts "Enter first user's username {space} display name (ie \"jon Jonathan\")"
    username_1, name_1 = STDIN.gets.strip.split(' ')
    STDOUT.puts "Enter second user's username {space} display name (ie \"sherry Sherry\")"
    username_2, name_2 = STDIN.gets.strip.split(' ')

    STDOUT.puts "Ok, I will create: "
    STDOUT.puts "User1: username = #{username_1}, name = #{name_1}"
    STDOUT.puts "User2: username = #{username_2}, name = #{name_2}"
    begin
      STDOUT.puts "Are you sure? (y/n)"
      input = STDIN.gets.strip.downcase
    end until %w(y n).include?(input)

    if input == 'y'
      User.create!(username: username_1, display_name: name_1)
      User.create!(username: username_2, display_name: name_2)
    else
      STDOUT.puts "Ok, no users created"
    end

  end
end
