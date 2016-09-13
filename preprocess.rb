CHUNK_LINE_SIZE = 10000
DATA_FILE = ARGV[0]

# takes in current index and returns the new file that will contain that index
def new_chunk(index)
  chunk_num = (index / CHUNK_LINE_SIZE).to_i
  write_file = File.new("data/chunk#{chunk_num}", "w")

  return write_file
end

begin
  # attempt to open file from cmd line arg
  read_file = File.open(DATA_FILE)
rescue
  # either no command line arg or a bad filename
  puts "ERROR: Couldn't find file: #{DATA_FILE}"
  abort
end

# write initial file
write_file = new_chunk(0)

# iterate through entire file, breaking it into chunks
read_file.each_with_index do |line, index|
  # if it's time to make a new chunk (ignore initial interation)
  if ((index % CHUNK_LINE_SIZE == 0) && index != 0)
    write_file.close
    write_file = new_chunk(index)
  end

  # write current line to chunk
  write_file.write(line)
end

write_file.close
