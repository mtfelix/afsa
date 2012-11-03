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
	
==========================
11.03

DONE:
	修改了getFood，数据改用参数的形式进行传递，避免了多次load造成的时间上
	的巨大消耗。在这方面似乎octave没有做优化，同样的文件会不停的调用而不会
	存储起来。

	修改了公告板中的一处小错误

	增加了存储log文件的功能,不过存储文件耗时过多,因而一般注释掉不使用

	更改了UF的一些性质,使得程序终于可以判断群聚结果了

问题:
	目前的程序中存在大量的参数传递情况,由于octave中的参数传递不是指针传递,
	而是复制数据.因而由于这些参数,必然造成程序调用函数时候的速度下降

	
	TODO 给程序添加代码,as many as possible!

	TODO 改用随机步长,且必须保证每个维度的步长范围是可以不相等的,这样才能
	适应更复杂的函数

	TODO 使用KD树改良follow中查找临近最大值点的部分,降低时间复杂度

	TODO 增加一些鱼群算法实际应用的例子,如:
	1. 找函数的极值点
	   2. 聚类
	      3. 非线性回归方程
		 4. 最佳平方逼近 --> 最佳一致逼近
