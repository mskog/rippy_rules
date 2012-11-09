require 'spec_helper'

describe RippyRules::Client do
  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:body, :uri]

  it "includes HTTParty" do
    rippy_rules = RippyRules::Client.new(WHATCD_USERNAME,WHATCD_PASSWORD)
    rippy_rules.kind_of?(HTTParty).should be_true
  end

  describe "#initialize" do
    context "when given valid authentication information" do
      it "authenticates the user" do
        rippy_rules = RippyRules::Client.new(WHATCD_USERNAME, WHATCD_PASSWORD)
        rippy_rules.class.cookies[:session].nil?.should == false
      end
    end

    context "when the authentication fails" do
      it "throws an AuthenticationError" do
        expect{rippy_rules = RippyRules::Client.new('foo', 'bar')}.to raise_error(RippyRules::AuthenticationError)
      end
    end
  end

  describe "#method_missing?" do
    let(:rippy_rules){RippyRules::Client.new(WHATCD_USERNAME, WHATCD_PASSWORD)}
    context "when given an action and a hash" do
      it "performs a request with the method name as the request type" do
        method = 'top10'
        params = {:type => :users}
        results = rippy_rules.send(method.to_sym, params)
        results['response'].first['results'].size == 10
      end
    end

    context "when the first parameter is not a hash" do
      it "throws an APIError" do
        method = 'eatmyshorts'
        param = 'foo'
        expect{rippy_rules.send(method.to_sym,param)}.to raise_error(RippyRules::APIError)
      end
    end
  end

  describe "#perform_request" do
    let(:rippy_rules){RippyRules::Client.new(WHATCD_USERNAME, WHATCD_PASSWORD)}
    it "performs a GET request with the correct parameters" do
      method = 'top10'
      query = {:limit => 10, :type => :torrents}
      rippy_rules.class.expects(:get).with("/ajax.php?action=top10", :query => query)
      rippy_rules.send(method.to_sym, query)
    end
  end

end