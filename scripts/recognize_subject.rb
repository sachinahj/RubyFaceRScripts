require 'rest_client'
require 'unirest'
require 'json'


module FaceR
  class RecognizeSubject
    def self.run(image_path, gallery_id)
      # intially detect face
      response = RestClient.post 'http://api.animetrics.com/v1/detect', 
      { 
        :api_key => API_KEY,
        :image => File.new(image_path) 
      }
      
      puts"\n"
      puts "response from POST detect --> #{response}"

      json = JSON.parse(response)
      unless json['images'].length < 1 or json['images'][0]['faces'].length < 1
        image_id = json['images'][0]['image_id']
        puts "image_id --> #{image_id}"
        top_left_x = json['images'][0]['faces'][0]['topLeftX']
        top_left_y = json['images'][0]['faces'][0]['topLeftY']
        width      = json['images'][0]['faces'][0]['width']
        height     = json['images'][0]['faces'][0]['height']  
      else
        return false
      end

      # recognize subject into gallery
      recognize_url = "http://api.animetrics.com/v1/recognize?" +
        "api_key=#{API_KEY}&" +
        "gallery_id=#{gallery_id}&" +
        "image_id=#{image_id}&" +
        "topLeftX=#{top_left_x}&" +
        "topLeftY=#{top_left_y}&" +
        "width=#{width}&" +
        "height=#{height}"

      response = RestClient.get recognize_url

      puts"\n"
      puts "response from GET --> #{response}"

      return response


    end
  end
end