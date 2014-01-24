require 'open-uri'

class Scraper
  attr_reader :html

  def initialize
    download = open("http://www.twittercounter.com/pages/100")
    @html = Nokogiri::HTML(download)
  end

  def get_names
    array = html.search(".name").collect {|a|a.text}
    # modified_array = array[0..-2]
    modified_array = array[0..1]
  end

  def get_handles
    array = html.search(".uname").collect{|h|h.text}
    #modified_array = array[0..-2]
    modified_array = array[0..1]
  end

  def associate_name_with_handle
    name_array = get_names
    handle_array = get_handles
    new_hash = {}
    counter = 0
    name_array.each do |name|
      new_hash[name_array[counter]] = handle_array[counter]
      counter += 1
    end
    new_hash
  end

  def add_to_database
    associate_name_with_handle.each do |name, handle|
      Celebrity.create(
        :name => name, 
        :handle => handle
      )
    end
  end

end

