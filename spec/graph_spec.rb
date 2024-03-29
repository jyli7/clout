require 'spec_helper'

describe Graph do
	before :each do
		@graph = Graph.new
	end

	describe "#new" do
		it "takes in no parameters and returns a Graph instance" do
			@graph.should be_instance_of Graph
		end
	end

	context "managing single nodes" do

		describe "#add_node_by_name!" do
			it "adds the node_name and node to the nodes array" do
				@graph.add_node_by_name!('Bob')
				@graph.nodes['Bob'].should be_instance_of Node
				@graph.nodes['Bob'].name.should eql 'Bob'
			end

			it "raises an exception if the node already exists" do
				@graph.add_node_by_name!('Bob')
				expect { @graph.add_node_by_name!('Bob') }.to raise_error
				expect { @graph.add_node_by_name!('Frank') }.to_not raise_error
			end
		end

		describe "#find_node_by_name" do
			it "returns the node, if it exists in the graph" do
				@graph.add_node_by_name!('Bob')
				@graph.find_node_by_name('Bob').should be_instance_of Node
				@graph.find_node_by_name('Bob').name.should eql 'Bob'
			end

			it "returns nil, if it doesn't exist" do
				@graph.add_node_by_name!('Bob')
				@graph.find_node_by_name('Frank').should be_nil
			end
		end

		describe "#find_or_add_node_by_name!" do
			it "returns the node, if it already exists" do
				@graph.add_node_by_name!('Bob')
				@graph.find_or_add_node_by_name!('Bob').should be_instance_of Node
				@graph.find_or_add_node_by_name!('Bob').name.should eql 'Bob'
			end

			it "adds and returns the node, even it it didn't exist" do
				@graph.find_or_add_node_by_name!('Bob').should be_instance_of Node
				@graph.find_or_add_node_by_name!('Bob').name.should eql 'Bob'
			end
		end
	end

	context "managing multiple nodes" do
		before :each do
			@graph.add_node_by_name!('Bob')
			@graph.add_node_by_name!('Frank')
			@graph.add_node_by_name!('Suzy')
			@bob_node = @graph.find_node_by_name('Bob')
			@frank_node = @graph.find_node_by_name('Frank')
			@suzy_node = @graph.find_node_by_name('Suzy')
		end

		describe "#node_objects" do
			it "returns an array of the node objects" do
				@graph.node_objects.should eq [@bob_node, @frank_node, @suzy_node]
			end
		end

		describe "#sorted_clout_hashes" do
			it "returns a hash with node names and node clouts, descending" do
				@bob_node.stub(:clout).and_return(5)
				@frank_node.stub(:clout).and_return(6)
				@suzy_node.stub(:clout).and_return(3)
				@graph.sorted_clout_hashes.should eql ([{"Frank" => 6}, {"Bob" => 5}, {"Suzy" => 3}])
			end
		end
	end

end