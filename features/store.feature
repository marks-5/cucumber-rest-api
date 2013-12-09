Feature: API
	In order to ensure quality
	As a user
	I want to be able to execute function tests against my API
	
	Scenario: Get Stores
		Given the API is running
		And I set headers:
		| StoresAPIKey | 5d740df4b73f0451dc1ad32d7126ec3d |
		When I send a GET request to "/api/stores/"
		Then the response status should be "200"
		And the JSON response should have "$..StoreNo" with the text "2286"
