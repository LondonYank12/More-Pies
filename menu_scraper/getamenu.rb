require 'rubygems'
require 'mechanize'


@br = Mechanize.new { |browser|      # Set the user-agent as Firefox - if the page knows we're Mechanize, it won't return all fields
  browser.user_agent_alias = 'Linux Firefox'
}


# START
puts "==================================================================="
page1 = @br.get('http://www.just-eat.co.uk')

#ENTER Postcode
puts "==================================================================="
je_form = page1.form('aspnetForm')
je_form.field_with(:name => "ctl00$ContentPlaceHolder1$Search$txtPost").value = "se9"
page2 = je_form.click_button

puts "==================================================================="
#puts "==================================================================="
#page.links.each do |link|
    #puts link.text
#end

puts "==================================================================="
# CLICK "ALL" link
page3 = page2.link_with(:text => /.*All .*/).click
pp page3

puts "==================================================================="
# CLICK "pappadom" link
page4 = page3.link_with(:href => /.*pappadom.menu.*/).click
#puts page4.inspect
#puts page4.methods.sort

puts "==================================================================="
pp page4
puts "==================================================================="
puts page4.instance_variables
#page5 = form2.submit

#puts "==================================================================="
#puts "==================================================================="
#pp page5

#iframe = page4.iframes.first
#page5 = iframe.click
#pp page5
#page4.frames.each do |iframe|
#    pp frame.inspect
#    puts "??????"
#end
