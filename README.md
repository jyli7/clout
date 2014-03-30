###How to run

$ ruby clout.rb

###Notable Tradeoffs

- On each node, we store the follower/followee objects instead of just their names so that we can send the follow! and unfollow! methods to each node, instead to the graph object. If we stored just the names on the node, 	we'd need to go through the graph object in order to look up nodes by their names. The downside of this strategy is that storing the nodes themselves comes at a greater memory cost.

###Assumptions:

- A follower can follow at most 1 person at a time.
- Names can be arbitrary long, with an arbitrary number of spaces (e.g. "John Jacob Jingleheimer Schmidt" is a valid name).
- Names can be empty strings.
- When we call "clout", we want the names listed in order of descending clout score, but we don't care about order when there is a tie (i.e. if two people have the same clout score, there's no guarantee re: who will be printed to STDOUT first)
	
	