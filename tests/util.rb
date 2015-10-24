require_relative '../lib/util.rb'
require 'test/unit'

class TestSSSAASUtil < Test::Unit::TestCase
    def test_random()
        util = SSSAAS::Util.new
        (0...10000).each do |x|
            assert(util.random() < util.prime, "Error! Random out of bounds of finite field!")
        end
    end

    def test_base_conversion()
        util = SSSAAS::Util.new
        (0...10000).each do |x|
            value = util.random()
            assert_equal(value, util.from_base64(util.to_base64(value)), "Error! Base64 encoding and decoding of ints not working!")
        end
    end

    def test_toBase64()
        util = SSSAAS::Util.new
        (0...10000).each do |x|
            value = util.random()
            assert_equal(44, util.to_base64(value).size, "Error! Base64 encoding returning the wrong size!")
        end
    end

    def test_split_merge()
        util = SSSAAS::Util.new
        values = ["N17FigASkL6p1EOgJhRaIquQLGvYV0", "0y10VAfmyH7GLQY6QccCSLKJi8iFgpcSBTLyYOGbiYPqOpStAf1OYuzEBzZR", "KjRHO1nHmIDidf6fKvsiXWcTqNYo2U9U8juO94EHXVqgearRISTQe0zAjkeUYYBvtcB8VWzZHYm6ktMlhOXXCfRFhbJzBUsXaHb5UDQAvs2GKy6yq0mnp8gCj98ksDlUultqygybYyHvjqR7D7EAWIKPKUVz4of8OzSjZlYg7YtCUMYhwQDryESiYabFID1PKBfKn5WSGgJBIsDw5g2HB2AqC1r3K8GboDN616Swo6qjvSFbseeETCYDB3ikS7uiK67ErIULNqVjf7IKoOaooEhQACmZ5HdWpr34tstg18rO"]
        values.each do |value|
            assert_equal(value, util.merge_ints(util.split_ints(value)), "Error! Splitting and merging of ints not working!")
        end
    end

    def test_mod_inverse()
        util = SSSAAS::Util.new
        (0...10000).each do |x|
            value = util.random()
            inverse = util.mod_inverse(value)
            result = (value * inverse) % util.prime
            assert_equal(1, result, "Error! mod_inverse not working!")
        end
    end
end