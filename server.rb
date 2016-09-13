require 'sinatra'

CHUNK_LINE_SIZE = 10000

# if no chunks were created, something is wrong
if (Dir["data/*"].length == 0)
  puts "ERROR: No data chunks detected, check that preprocess ran properly"
  abort
end

# route given in problem
get '/lines/:line_index'  do
  line_index = params['line_index'].to_i    # read line_index from url
  file_num = (line_index / CHUNK_LINE_SIZE).to_i    # calculate which chunk the desired index will be in
  number_of_files = Dir["data/*"].length    # check data directory for # of chunks

  if (file_num >= number_of_files)
    # given index was out of bounds, return 413
    return status 413
  end

  filepath = "data/chunk#{file_num}"    # path of target chunk

  # open proper chunk and read through each line
  File.open(filepath).each_with_index do |line, index|
    global_index = index + (file_num * 10000) # each chunk will only have index 0-10000, so calculate 'global' index

    if (global_index == line_index)
      # found our line, return it as 200 OK
      return line
    end
  end

  return status 413   # given index was out of bounds, but within the last chunk
end
