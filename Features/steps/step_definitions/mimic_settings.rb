Given(/^I set the test server in JSON format with the following values:$/) do |request_data|
	Mimic.mimic(:port => 11234) do
		request_data.hashes.each do |request_details|

			url = request_details['uri']
			json = request_details['json']
			request_type = request_details['request_type']
			statuscodeno = request_details['statuscodeno']
			if request_type == 'post' 
		  		post(url).returning(json,statuscodeno.to_i)
			else
				get(url).returning(json,statuscodeno.to_i)
		  	end
		end
	end
end 

