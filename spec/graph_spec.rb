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

		describe "#find_or_add_node_by_name" do
			it "returns the node, if it already exists" do
				@graph.add_node_by_name!('Bob')
				@graph.find_or_add_node_by_name('Bob').should be_instance_of Node
				@graph.find_or_add_node_by_name('Bob').name.should eql 'Bob'
			end

			it "adds and returns the node, even it it didn't exist" do
				@graph.find_or_add_node_by_name('Bob').should be_instance_of Node
				@graph.find_or_add_node_by_name('Bob').name.should eql 'Bob'
			end
		end
	end

	context "managing node relationships" do
	end
end