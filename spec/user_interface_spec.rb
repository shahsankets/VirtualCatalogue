require 'spec_helper'

describe "User Interface" do
  include Rack::Test::Methods

  it "should respond to /" do
    get '/'
    [200, 302].should include(last_response.status)
  end

  it "should respond to / and redirect to /index.html" do
    get '/'
    last_response.status.should == 302
    last_response.headers.should include 'Location'
    last_response.headers['Location'].should include 'index.html'
  end

  it "should respond to /index.html" do
    get '/index.html'
    last_response.should be_ok
  end

  it "should respond to /product" do
    get '/product'
    last_response.should be_ok
  end
  context "display the data associated with the product" do
    before do
      get '/product', :product => Product.new(5, "1234567890", "iPad", "Apple", "Very expensive product!", "Personal Gadgets", 500.00, "path_to_image", "GFA1")
    end

    it {last_response.body.should include '5'}
    it {last_response.body.should include '1234567890'}
    it {last_response.body.should include 'iPad'}
    it {last_response.body.should include 'Apple'}
    it {last_response.body.should include 'Very expensive product!'}
    it {last_response.body.should include 'Personal Gadgets'}
    it {last_response.body.should include '500.00'}
    it {last_response.body.should include 'path_to_image'}
    it {last_response.body.should include 'GFA1'}
  end

  it "should load the storage object when it starts" do
    app.settings.my_storage.should_not be_nil
  end

  it "should load the catalogue object when it starts" do
    app.settings.my_catalogue.should_not be_nil
  end

  it "the catalogue should have the same products of the storage when the app starts" do
    app.settings.my_storage.should have(app.settings.my_catalogue.products.size).products
  end

  it "should respond to /process" do
    post '/process', 'search_term' => nil
    last_response.should be_ok
  end
end
