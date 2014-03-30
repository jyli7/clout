require 'spec_helper'

describe "#prompt" do
	it "prints out the prompt and waits for input" do
		STDOUT.should_receive(:print).with("> ")
		prompt("> ")
	end
end

describe "#follows_regex" do
	it "matches the follower name and followee name" do
		match_data = follows_regex.match('A follows B')
		match_data[1].should eql 'A'
		match_data[2].should eql 'B'
	end

	it "matches empty strings, if blank names are provided" do
		match_data = follows_regex.match(' follows ')
		match_data[1].should eql ''
		match_data[2].should eql ''
	end

	it "does not match, when no names are provided" do
		match_data = follows_regex.match('follows')
		match_data.should be_nil
	end
end

describe "#clout_regex" do
	it "matches the person whose clout we're asking for" do
		match_data = clout_regex.match('clout A')
		match_data[1].should eql 'A'
	end

	it "matches the empty string, if a blank name is provided" do
		match_data = clout_regex.match('clout ')
		match_data[1].should eql ''
	end

	it "does not match when there is no name provided" do
		match_data = clout_regex.match('clout')
		match_data.should be_nil
	end
end

describe "#clout_global_regex" do
	it "matches when there is no whitespace" do
		match_data = clout_global_regex.match('clout')
		match_data.should_not be_nil
	end

	it "matches when there is trailing whitespace" do
		match_data = clout_global_regex.match('clout   ')
		match_data.should_not be_nil
	end

	it "does not match when there is initial whitespace" do
		match_data = clout_global_regex.match('  clout')
		match_data.should be_nil
	end
end

describe "#exit_regex" do
	it "matches when there is no whitespace" do
		match_data = exit_regex.match('exit')
		match_data.should_not be_nil
	end

	it "matches when there is whitespace" do
		match_data = exit_regex.match('exit   ')
		match_data.should_not be_nil
	end

	it "does not match when there is initial whitespace" do
		match_data = exit_regex.match('   exit')
		match_data.should be_nil
	end
end

describe "#print_clout" do
	before :each do
		@node = Node.new('Test')
	end
	
	it "says there are no followers, when clout is 0" do
		@node.stub(:clout) { 0 }
		STDOUT.should_receive(:puts).with("#{@node.name} has no followers")
		print_clout(@node)
	end

	it "says there is 1 follower, when clout is 1" do
		@node.stub(:clout) { 1 }
		STDOUT.should_receive(:puts).with("#{@node.name} has 1 follower")
		print_clout(@node)
	end

	it "says there are X followers, when clout is X" do
		@node.stub(:clout) { 23 }
		STDOUT.should_receive(:puts).with("#{@node.name} has 23 followers")
		print_clout(@node)
	end
end