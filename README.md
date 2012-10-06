Artificial_Fish_Algorithm
=========================

the implementation of artificial fish algorithm and its improvement

=========================
10.06

DONE:
	The BUG in follow-Movement is fixed.
	The Union_Find part of the Algorithm is checked and no BUG has been
	found yet.

Problems:
	The swarm-Movement is useless in the process of the Algorithm, disable
	this part speed up the program while the result remain the same. This
	part fast never be done once during the process, which indicate that
	some problem exists.
	Union_Find part works right, but can't output the right result, as
	more prey- or random-Movement happen after some iterations. After
	about a dozen iterations, the number of classes increases.

TODO:
	Save all the plot_file during each iteration, so that the movement of
	fish will be easily checked.
	Save so many data as possible in Files (probably different files) for
	analysing the program's performance.
	Find out the problem in swarm-Movement.
	Adjust the performance of random- and prey-Movement. (maybe: ONLY after
	continuesly two or more random- and prey-Movements does UF_Break() one 
	time.)
	Speed the follow- and swarm-Movement up!
	
