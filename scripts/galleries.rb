require 'rest_client'
require 'unirest'
require 'json'

module FaceR
  class Galleries

    def self.view_galleries
      response = RestClient.get "http://api.animetrics.com/v1/list_galleries?api_key=#{API_KEY}"
      puts "response --> #{response}"
      return response.body
    end

    def self.view_subjects(gallery_id)
      response = RestClient.get "http://api.animetrics.com/v1/view_gallery?api_key=#{API_KEY}&gallery_id=#{gallery_id}"
      puts "response --> #{response}"
      return response.body
    end

  end
end