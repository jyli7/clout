###How to run

$ ruby clout.rb

###Notable Tradeoffs

- The spec says that when A follows B, B "inherits" all of A's followers. I chose to reflect this inheritance at the clout level, but not at the data storage level.

This is what I mean: I could have set it up so that when A follows B, A's followers get pushed on to B's followers array. The upside of this is that in order to calculate the clout of B, we simply look at the size of B's followers array. The downside, however, is that if A follows B, and B follows C, what happens if A stops following B? Well, we'll have to then go into C, as well as every subsequent followee (suppose there's a D, E, etc.) and remove A's followers from the followers array in C, D, E, etc. To me, the downside here clearly outweighs the upside, given that (1) if we were using a DB, this could end up being a lot of writes (which are most costly than reads, all things equal) and (2) this sort of "upward propagation" along the followee chain is hard to reason about / is therefore likely to lead to bugs for myself and other programmers down the road.

When I say I chose to reflect the inheritance of followers at the "clout" level instead, I mean that I don't store A's followers on B. Instead, every time we ask for B's clout, I look *down* through the followers chain and count up all of B's extended network, in a breadth first search fashion (while making sure that this doesn't lead to an infinite loop). The downside of this approach is that we have to walk down the tree every time we ask for a node's clout. In real-life/production, we might be able to mitigate this problem significantly by caching this value, so long as its value doesn't change super frequently.

- On each node, we store the follower/followee objects instead of just their names so that we can send the follow! and unfollow! methods to each node, instead to the graph object. If we stored just the names on the node, 	we'd need to go through the graph object in order to look up nodes by their names. The downside of this strategy is that storing the nodes themselves comes at a greater memory cost.

###Assumptions:

- A follower can follow at most 1 person at a time.
- Names can be arbitrary long, with an arbitrary number of spaces (e.g. "John Jacob Jingleheimer Schmidt" is a valid name).
- Names can be empty strings.
- When we call "clout", we want the names listed in order of descending clout score, but we don't care about order when there is a tie (i.e. if two people have the same clout score, there's no guarantee re: who will be printed to STDOUT first)