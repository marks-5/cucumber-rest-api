Feature: API
In order to ensure quality
As a  developer
I want to be able to execute functional tests against my API using Mimic for PUT method


Scenario Outline: Testing the 200 status using PUT
	Given I set the test server in JSON format with the following values:
	| uri                        | json | request_type | statuscodeno |
	| /api/coffeefinder/Testpost |      | put          | 200          |
	When I send a PUT request to "<uri>"
	Then the response status should be "<statuscodeno>"
	Examples:
	| uri                        | json | request_type | statuscodeno |
	| /api/coffeefinder/Testpost |      | put          | 200          |


Scenario Outline: Testing the 404 status using PUT
	Given I set the test server in JSON format with the following values:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Testpost1 |      | put          | 404          |
	When I send a PUT request to "<uri>"
	Then the response status should be "<statuscodeno>"
	Examples:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Testpost1 |      | put          | 404          |

Scenario Outline: Testing the 200 status by passing payload data  without JSON response using PUT
	Given I set the test server in JSON format with the following values:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Testpost2 |      | put          | 200          |
	When I send a PUT request to "<uri>" with the following:
	| test1 | a |
	| test2 | b |
	Then the response status should be "<statuscodeno>"
    Examples:
	| uri                                  | json | request_type | statuscodeno |
	| /api/coffeefinder/location/Testpost2 |      | put          | 200          |

Scenario Outline: Testing the 200 status by passing payload data with JSON response using PUT
	Given I set the test server in JSON format with the following values:
	| uri                                  | json                         | request_type | statuscodeno |
	| /api/coffeefinder/location/Testpost2 | {"test1": "1", "test2": "2"} | put          | 200          |
	When I send a PUT request to "<uri>" with the following:
	| test1 | a |
	| test2 | b |
	Then the response status should be "<statuscodeno>"
    Examples:
	| uri                                  | json                         | request_type | statuscodeno |
	| /api/coffeefinder/location/Testpost2 | {"test1": "1", "test2": "2"} | put          | 200          |



