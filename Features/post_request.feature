Feature: API
In order to ensure quality
As a  developer
I want to be able to execute functional tests against my API using Mimic by using POST method


Scenario Outline: Testing the 404 status using POST
	Given I set the test server in JSON format with the following values:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Jerusalem  |      | post         | 404          |
	| /api/coffeefinder/location/hsdhs      |      | post         | 404          |
	When I send a POST request to "<uri>"
	Then the response status should be "<statuscodeno>"
	Examples:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Jerusalem  |      | post         | 404          |
	| /api/coffeefinder/location/hsdhs      |      | post         | 404          |


Scenario Outline: Display 200 status and store list with valid location using POST
	Given I set the test server in JSON format with the following values:
	| uri                                            | json                                                       | request_type | statuscodeno |
	| /api/coffeefinder/location/London/listprice     | {"MandS": "£2", "Waitrose": "£1.75", "Sainsbury": "£1"}    | post         | 200          |
	| /api/coffeefinder/location/Birmingham/listprice | {"MandS": "£2", "Waitrose": "£2", "Sainsbury": "£1.50"}    | post         | 200          |
	| /api/coffeefinder/location/Manchester/listprice | {"MandS": "£2", "Waitrose": "£1.75", "Sainsbury": "£1.75"} | post         | 200          |
	When I send a POST request to "<uri>"
	Then the response status should be "<statuscodeno>"
	And the JSON response should be:
	"""
	<json>
	"""
	Examples:
	| uri                                            | json                                                       | request_type | statuscodeno |
	| /api/coffeefinder/location/London/listprice     | {"MandS": "£2", "Waitrose": "£1.75", "Sainsbury": "£1"}    | post         | 200          |
	| /api/coffeefinder/location/Birmingham/listprice | {"MandS": "£2", "Waitrose": "£2", "Sainsbury": "£1.50"}    | post         | 200          |
	| /api/coffeefinder/location/Manchester/listprice | {"MandS": "£2", "Waitrose": "£1.75", "Sainsbury": "£1.75"} | post         | 200          |
