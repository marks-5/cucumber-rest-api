Feature: API
In order to ensure quality
As a  developer
I want to be able to execute functional tests against my API using Mimic by using GET method

Scenario: Testing the 200 status using GET
	Given I set the test server in JSON format with the following values:
	| uri                       | json                                                  | request_type | statuscodeno |
	| /api/coffeefinder/location | { "Location": ["London", "Birmingham", "Manchester"]} | get          | 200          |
	When I send a GET request to "/api/coffeefinder/location"
	Then the response status should be "200"
	And the JSON response should be:
	"""
	{"Location": ["London", "Birmingham", "Manchester"]}
	"""

Scenario: Testing the 404 status using GET
	Given I set the test server in JSON format with the following values:
	| uri                        | json | request_type | statuscodeno |
	| /api/coffeefinder/location1 |      | get          | 404          |
	When I send a GET request to "/api/coffeefinder/location1"
	Then the response status should be "404"