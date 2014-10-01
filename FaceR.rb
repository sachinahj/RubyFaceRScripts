require 'rest_client'
require 'unirest'
require 'json'

gallery_id = "MKS"
subject_id = "sachin"

response = RestClient.post 'http://api.animetrics.com/v1/detect', 
  { :api_key => api_key,
    :image => File.new("./photo2.jpeg") }

puts "response --> #{response}"
json = JSON.parse(response)

unless json['images'].length < 1 or json['images'][0]['faces'].length < 1
  image_id = json['images'][0]['image_id']

  puts image_id
  # {...} store image_id locally 
  
  top_left_x = json['images'][0]['faces'][0]['topLeftX']
  top_left_y = json['images'][0]['faces'][0]['topLeftY']
  width      = json['images'][0]['faces'][0]['width']
  height     = json['images'][0]['faces'][0]['height']  
end

response = RestClient.post 'http://api.animetrics.com/v1/detect_features', 
  { :api_key => api_key,
    :image_id => image_id,
    :topLeftX => top_left_x,
    :topLeftY => top_left_y,
    :width => width,
    :height => height,
    :selector => "FULL"
  }

puts "response --> #{response}"
json = JSON.parse(response)

File.open("./facer.json", "w") do |f|
  f.write(JSON.pretty_generate(json))
end

response = RestClient.get 'http://api.animetrics.com/v1/enroll', 
  { :api_key => api_key,
    :subject_id => subject_id,
    :gallery_id => gallery_id,
    :image_id => image_id,
    :topLeftX => top_left_x,
    :topLeftY => top_left_y,
    :width => width,
    :height => height
  }

puts "response --> #{response}"
puts api_key

response = RestClient.get "http://api.animetrics.com/v1/list_galleries?api_key=#{api_key}"


puts "response --> #{response}"











