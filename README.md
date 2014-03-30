###Tradeoffs
	* On each node, we store the follower/followee objects instead of just their names so that we can send the follow! and unfollow! methods to each node, instead to the graph object. If we stored just the names on the node, 	we'd need to go through the graph object in order to look up nodes by their names. This choice comes at the cost of storing full node objects (in the followers/followees array, within each node) instead of simply their names.

###Assumptions:
	* A follower can have at most 1 followee at a time
	* Names can be arbitrary long (e.g. "John Jacob Jingleheimer Schmidt" is a valid name).
	* Names can be empty strings
	
	
	