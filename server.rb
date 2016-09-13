require 'sinatra'

get '/lines/:line_index'  do
  line_index = params['line_index'].to_i

  line_count = %x{wc -l < data.txt}.to_i

  if line_index > (line_count - 1)
    return status 413
  end

  puts "lines: #{line_count}"
  File.open("data.txt").each_with_index do |line, index|
    if index == line_index
      return line
    end
  end
end