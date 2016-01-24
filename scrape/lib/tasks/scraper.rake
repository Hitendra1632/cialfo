require 'json'
require 'open-uri'

namespace :scraper do
  desc "TODO"
    task scraping: :environment do
  	    scraper = Mechanize.new
		@info=[]
		@next="Next"
		name=[]
		rank=[]
		tuition_fees=[]
		total_enrollment=[]
		acceptance_rate=[]
		average_retention_rates=[]
		graduation_rate=[]

		#open a file to insert the data
		infofile=File.open("public/scrape.json",'w')

		# counter to scrape all pages 
		page_no=1
		while(@next.include? "Next")

			#link for scraping
			link="http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/data/page+#{page_no}"
			#get the scrape page
			scraper.get(link) do |page|
			  #get the data y serching css	
			  name=page.search('tbody').search('.school-name').map{ |n| n.text.strip }
			  rank=page.search('tbody').search('.rankscore-bronze').map{ |n| n.text.strip }
			  tuition_fees=page.search('tbody').search('.search_tuition_display').map{ |n| n.text.strip }
			  total_enrollment=page.search('tbody').search('.total_all_students').map{ |n| n.text.strip }
			  acceptance_rate=page.search('tbody').search('.r_c_accept_rate').map{ |n| n.text.strip }
			  average_retention_rates=page.search('tbody').search('.r_c_avg_pct_retention').map{ |n| n.text.strip }
			  graduation_rate=page.search('tbody').search('.r_c_avg_pct_grad_6yr').map{ |n| n.text.strip }
			  
			  # loop for making hashs
			  for i in 0..name.size-1
			  	data={}
			  	data[:name]=name[i]
			  	data[:rank]=rank[i]
			  	data[:tuition_fees]=tuition_fees[i]
			  	data[:total_enrollment]=total_enrollment[i]
			  	data[:acceptance_rate]=acceptance_rate[i]
			  	data[:average_retention_rates]=average_retention_rates[i]
			  	data[:graduation_rate]=graduation_rate[i]
			  	@info.append(data)
			  end		  
			  
			  #checking for next page
			  @next=page.search('p').search('#pagination').text
			end
			#counter fo page number
			page_no=page_no+1
		end
		# Converting the data into json
		@info=JSON.generate(@info)
		#writing into the file
		infofile.write(@info)
		#closing the file
		infofile.close
    end

end
