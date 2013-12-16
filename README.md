cucumber_rest_api
=================

[![Gem Version](https://badge.fury.io/rb/cucumber-rest-api.png)](http://badge.fury.io/rb/cucumber-rest-api)  

Please see the wiki for documentation, this project expands on the excellent cucumber-api-steps and implements a basic HTTP client for testing remote and local JSON and XML restful clients.  

We needed a tool to run some simple BDD functional tests against the APIs we were building so created this little Ruby Gem. The tool uses the standard Ruby Net::HTTP client to make requests to your REST API, using cucumber you can write your BDD tests and the built in steps will execute and parse the request response for you.  

[Wiki](https://github.com/DigitalInnovation/cucumber_rest_api/wiki)  

###Status
Currently we have implemented JSON based REST support, XML based support will be coming in a later release.  

###Coming Soon
Simple set up to create scaffold features and custom steps files   

###Acknowledgements
https://github.com/jayzes/cucumber-api-steps

https://github.com/lukeredpath/mimic
