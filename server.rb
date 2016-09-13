require 'sinatra'

get '/lines/:line_index'  do
  File.open("data.txt").each_with_index do |line, index|
    if index == params['line_index'].to_i
      return line
    end
  end
end