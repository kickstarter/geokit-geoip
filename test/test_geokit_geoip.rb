require File.dirname(__FILE__) + '/test_helper.rb'

class TestGeokitGeoip < Test::Unit::TestCase

  context "GeoIPCityGeocoder" do
    setup do
      @geocoder = Geokit::Geocoders::GeoIPCityGeocoder
    end

    should "have a default geoip_data_path" do
      path = File.expand_path(File.join(File.dirname(__FILE__), "..", "data", "GeoLiteCity.dat"))
      assert_equal path, Geokit::Geocoders.geoip_data_path
    end

    should "be able to set geoip_data_path" do
      orig_path = Geokit::Geocoders.geoip_data_path
      Geokit::Geocoders.geoip_data_path = "foo"
      assert_equal "foo", Geokit::Geocoders.geoip_data_path
      # Reset
      Geokit::Geocoders.geoip_data_path = orig_path
    end


    bad_ips = ["nonesuch", "0.0.0.0", "127.0.0.1"]
    bad_ips.each do |bad_ip|
      should "return a blank GeoLoc for #{bad_ip}" do
        assert_equal Geokit::GeoLoc.new, @geocoder.geocode(bad_ip)
      end
    end

    context "with a good ip" do
      setup { @ip = '67.244.97.190' }
      should "set the right attributes" do
        loc = @geocoder.geocode(@ip)
        assert_equal "New York", loc.city
        assert_equal "NY", loc.state
        assert_equal "US", loc.country_code
        assert (40..41).include?(loc.lat)
        assert (-74..073).include?(loc.lng)
        assert 5, loc.zip.size
      end
    end
  end
end
