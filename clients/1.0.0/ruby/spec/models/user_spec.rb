=begin
#Assessment Network API

#> Stores content for the Assessment Network  API Version is specified in the URL path as `api/<version>/resource` Version will default to the latest if it's ommited  All endpoints require an API key to be passed in the request header. API keys can be obtained by members at www.a15k.org. 

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.3.1

=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for A15kClient::User
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'User' do
  before do
    # run before each test
    @instance = A15kClient::User.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of User' do
    it 'should create an instance of User' do
      expect(@instance).to be_instance_of(A15kClient::User)
    end
  end
  describe 'test attribute "id"' do
    it 'should work' do
       # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "role"' do
    it 'should work' do
       # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
       #validator = Petstore::EnumTest::EnumAttributeValidator.new('String', ["power_user", "standard_user"])
       #validator.allowable_values.each do |value|
       #  expect { @instance.role = value }.not_to raise_error
       #end
    end
  end

  describe 'test attribute "username"' do
    it 'should work' do
       # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "name"' do
    it 'should work' do
       # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end

