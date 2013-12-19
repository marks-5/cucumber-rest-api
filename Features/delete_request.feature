Feature: API
In order to ensure quality
As a developer
I want to be able to execute functional tests against my API using Mimic for DELETE method


Scenario Outline: Testing the 200 status using DELETE
	Given I set the test server in JSON format with the following values:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Jerusalem |      | delete       | 200          |
	When I send a DELETE request to "<uri>"
	Then the response status should be "<statuscodeno>"
	Examples:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Jerusalem |      | delete       | 200          |

Scenario Outline: Testing the 403 status using DELETE
	Given I set the test server in JSON format with the following values:
	| uri                              | json | request_type | statuscodeno |
	| /api/coffeefinder/location/admin |      | delete       | 403          |
	When I send a DELETE request to "<uri>"
	Then the response status should be "<statuscodeno>"
	Examples:
	| uri                              | json | request_type | statuscodeno |
	| /api/coffeefinder/location/admin |      | delete       | 403          |

