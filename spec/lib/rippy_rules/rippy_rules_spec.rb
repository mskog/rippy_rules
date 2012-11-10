require 'spec_helper'

describe RippyRules::Client do
  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:body, :uri]

  subject{RippyRules::Client.new(WHATCD_USERNAME,WHATCD_PASSWORD)}

  it {subject.kind_of?(HTTParty).should be_true}

  describe "#initialize" do
    context "when given valid authentication information" do
      it "authenticates the user" do
        subject.class.cookies[:session].nil?.should be_false
      end
    end

    context "when the authentication fails" do
      it "throws an AuthenticationError" do
        expect{RippyRules::Client.new('foo', 'bar')}.to raise_error(RippyRules::AuthenticationError)
      end
    end
  end

  describe "#search" do
    it "calls browse with the given string as 'searchstr'" do
      str = 'bruce springsteen'
      subject.expects(:browse).with({searchstr: str})
      subject.search str
    end
  end

  describe "#method_missing?" do
    context "when given an action and a hash" do
      it "performs a request with the method name as the request type" do
        method = 'top10'
        params = {type: :users}
        results = subject.send(method.to_sym, params)
        results['response'].first['results'].size.should eq(10)
      end
    end

    context "when the first parameter is not a hash" do
      it "throws an APIError" do
        method = 'eatmyshorts'
        param = 'foo'
        expect{subject.send(method.to_sym,param)}.to raise_error(RippyRules::APIError)
      end
    end
  end

  describe "#perform_request" do
    it "performs a GET request with the correct parameters" do
      method = 'top10'
      query = {limit: 10, type: :torrents}
      query_with_method = query.merge({action: method})
      subject.class.expects(:get).with("/ajax.php", query: query_with_method)
      subject.send(method.to_sym, query)
    end
  end

end