	$ cat /proc/cpuinfo | grep name
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
        $ cd c; make; ./test; ./test_nonopt; ./forking 4; cd ../
	single avg 0.05010
	multi avg 0.09582
	single avg 0.16896
	multi avg 0.08987
	workers 4
	multi avg 0.09512, 3.141593
	$ cd haskell; stack bench; cd ..
	Benchmark first: RUNNING...
	threads avaialble: 4
	benchmarking idiomatic fork 4
	time                 50.20 ms   (49.20 ms .. 50.83 ms)
			     0.999 R²   (0.998 R² .. 1.000 R²)
	mean                 50.59 ms   (50.08 ms .. 52.07 ms)
	std dev              1.423 ms   (461.5 μs .. 2.430 ms)

	benchmarking idiomatic async 4
	time                 49.81 ms   (49.27 ms .. 50.17 ms)
			     1.000 R²   (0.999 R² .. 1.000 R²)
	mean                 49.92 ms   (49.67 ms .. 50.41 ms)
	std dev              627.5 μs   (385.4 μs .. 884.2 μs)

	benchmarking idiomatic parallel 4
	time                 99.16 ms   (98.85 ms .. 99.50 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 99.23 ms   (99.09 ms .. 99.45 ms)
	std dev              298.4 μs   (163.5 μs .. 464.3 μs)

	benchmarking idiomatic single
	time                 100.8 ms   (100.7 ms .. 101.0 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 100.7 ms   (100.6 ms .. 100.9 ms)
	std dev              230.9 μs   (166.6 μs .. 330.2 μs)

	Benchmark first: FINISH

	$ cd rust; cargo +nightly bench
	running 3 tests
	test tests::bench_cuncurrent4 ... bench:  53,767,511 ns/iter (+/- 2,661,647)
	test tests::bench_cuncurrent8 ... bench:  55,919,458 ns/iter (+/- 3,299,292)
	test tests::bench_single      ... bench: 107,468,007 ns/iter (+/- 3,167,809)

	test result: ok. 0 passed; 0 failed; 0 ignored; 3 measured; 0 filtered out

