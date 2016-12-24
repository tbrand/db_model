require "./spec_helper"
require "./mock"

db_model User, id : Int32, name : String

describe "db_model" do
  it "define model" do
    user = User.new(1, "name")
    user.id.should eq(1)
    user.name.should eq("name")
  end

  it "read model from row" do
    user = User.read(MockRow)
    user.id.should eq(1)
    user.name.should eq("name")
  end

  it "throw query and craete array of the models" do
    users = User.query(MockDB, "dummy")
    users.size.should eq(1)
    users.first.id.should eq(1)
    users.first.name.should eq("name")
  end

  it "create from json" do
    json = "{\"id\":1,\"name\":\"name\"}"
    user = User.from_json(json)
    user.id.should eq(1)
    user.name.should eq("name")
    user.to_json.should eq(json)
  end
end
