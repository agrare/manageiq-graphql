require "manageiq_helper"

RSpec.describe "Vm queries" do
  describe "'vms' field" do
    as_user do
      before do
        FactoryBot.create(:vm, :name => "Alice's VM")
      end

      it "will return the specified fields of all vms" do
        execute_graphql <<~QUERY
          {
            vms {
              edges {
                node {
                  name
                }
              }
            }
          }
        QUERY

        expect(response.parsed_body).to eq("data" => {"vms" => { "edges" => [{ "node" => {"name" => "Alice's VM"} }] } })
      end
    end
  end
end
