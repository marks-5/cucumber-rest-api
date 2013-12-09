Feature: API
	In order to ensure quality
	As a user
	I want to be able to execute function tests against my API
	
	Scenario: Successful login
		Given the API is running
		When I send a POST request to "/login/authenticate" with the following:
		"""
		{"Username":"nic@thatlondon.com", "Password":"Password1"}
		"""
		Then the response status should be "200"
		And the JSON response should have "$..StatusCode" with the text "200"

	Scenario: Bad login
		Given the API is running
		When I send a POST request to "/login/authenticate" with the following:
		| Username | nic@home.com |
		| Password | password     |
		Then the response status should be "200"
		And the JSON response should have "$..StatusCode" with the text "401"
