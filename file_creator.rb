file = File.new(ARGV[0], "w")

# generate file with n lines containing ints from 1-100000
ARGV[1].to_i.times do |n|
  file.write(Random.rand(100000).to_s + "\n")
end

file.close