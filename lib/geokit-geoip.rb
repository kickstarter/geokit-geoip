# Normally we would want this in lib/ext, but it needs to be loaded before the initializers.

require 'geokit'
require 'geoip'

module Geokit
  module Geocoders

    @@geoip_data_path = File.expand_path(File.join(File.dirname(__FILE__),'..','data','GeoLiteCity.dat')) 
    __define_accessors

    # Provide geocoding based upon an IP address.  The underlying web service is maxmind.com.
    # MaxMind City is a paid-for service, provides country, region, and city. Updated every month.
    class GeoIpCityGeocoder < Geocoder
      # Given an IP address, returns a GeoLoc instance which contains latitude,
      # longitude, city, and country code. Sets the success attribute to false if the ip
      # parameter does not match an ip address.
      def self.do_geocode(ip, options = {})
        return GeoLoc.new unless /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})?$/.match(ip)
        if (res = ::GeoIP.new(Geocoders::geoip_data_path).city(ip))
          loc = GeoLoc.new({
            :provider => 'maxmind_city',
            :lat => res.latitude,
            :lng => res.longitude,
            :city => res.city_name,
            :state => res.region_name,
            :zip => res.postal_code,
            :country_code => res.country_code2
          })
          # Work around Geokit's jankiness
          loc.success = res.city_name && res.city_name != ''
          loc
        else
          GeoLoc.new
        end
      end

    end
  end
end

