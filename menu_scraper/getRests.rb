#for each pcs entry
#get all menu urls
#store them all in eachPCS.txt file in pcs dir

file = File.new("pcs.txt", "r") 
while (code = file.gets) 
system("ruby scrapify.rb #{code}")
sleep (1 + rand(66))
end 
file.close
