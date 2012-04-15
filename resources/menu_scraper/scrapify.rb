require 'rubygems'
require 'mechanize'
postcode=ARGV.first ; 
puts postcode

@br = Mechanize.new { |browser|      # Set the user-agent as Firefox - if the page knows we're Mechanize, it won't return all fields
  browser.user_agent_alias = 'Linux Firefox'
}


# START
puts "==================================================================="
page1 = @br.get('http://www.just-eat.co.uk')
pp page1

#ENTER Postcode
puts "==================================================================="
je_form = page1.form('aspnetForm')
je_form.field_with(:name => "ctl00$ContentPlaceHolder1$Search$txtPost").value = postcode
sleep 1
page2 = je_form.click_button
pp page2
puts "where is the postcode now..?"
puts "==================================================================="
puts "==================================================================="
page2.links.each do |link|
    puts link.text
end

puts "==================================================================="
puts "==================================================================="
# CLICK "ALL" link
sleep 2
targetpage = page2.link_with(:text => /.*All .*/).click
File.open("rests_#{postcode}.txt", 'w') {|f| f.write(targetpage.body) }
