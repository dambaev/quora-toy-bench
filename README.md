testing on i5-7200u:

	$ cat /proc/cpuinfo
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz

	$ cd c; make; ./test; ./test_nonopt; ./forking 4; cd ..
	single avg 0.05008
	multi avg 0.09541

	single avg 0.16896
	multi avg 0.09009

	workers 4
	multi avg 0.09575, 3.141593

	$ cd haskell; stack benchl cd ..
	threads avaialble: 4
	benchmarking idiomatic fork 4
	time                 157.3 ms   (152.4 ms .. 164.0 ms)
		       0.999 R²   (0.998 R² .. 1.000 R²)
	mean                 157.3 ms   (155.3 ms .. 160.5 ms)
	std dev              3.551 ms   (1.795 ms .. 5.406 ms)
	variance introduced by outliers: 12% (moderately inflated)

	benchmarking ffi fork 4
	time                 78.71 ms   (76.75 ms .. 81.22 ms)
		       0.998 R²   (0.996 R² .. 1.000 R²)
	mean                 78.78 ms   (78.03 ms .. 80.11 ms)
	std dev              1.663 ms   (868.9 μs .. 2.410 ms)

	benchmarking idiomatic async 4
	time                 159.5 ms   (152.3 ms .. 166.9 ms)
		       0.998 R²   (0.995 R² .. 1.000 R²)
	mean                 155.4 ms   (153.5 ms .. 158.6 ms)
	std dev              3.457 ms   (2.313 ms .. 4.717 ms)
	variance introduced by outliers: 12% (moderately inflated)

	benchmarking ffi async 4
	time                 78.77 ms   (77.50 ms .. 80.07 ms)
		       1.000 R²   (0.999 R² .. 1.000 R²)
	mean                 78.17 ms   (77.53 ms .. 79.04 ms)
	std dev              1.237 ms   (861.6 μs .. 1.730 ms)

	benchmarking idiomatic parallel 4
	time                 168.2 ms   (162.1 ms .. 184.1 ms)
		       0.995 R²   (0.980 R² .. 1.000 R²)
	mean                 163.0 ms   (159.7 ms .. 170.1 ms)
	std dev              6.981 ms   (2.688 ms .. 10.51 ms)
	variance introduced by outliers: 12% (moderately inflated)

	benchmarking ffi parallel 4
	time                 80.56 ms   (77.81 ms .. 81.77 ms)
		       0.998 R²   (0.991 R² .. 1.000 R²)
	mean                 84.84 ms   (82.94 ms .. 86.95 ms)
	std dev              3.457 ms   (2.768 ms .. 4.670 ms)

	benchmarking idiomatic single
	time                 583.9 ms   (583.6 ms .. 584.4 ms)
		       1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 583.9 ms   (583.9 ms .. 584.0 ms)
	std dev              69.95 μs   (6.694 μs .. 87.85 μs)
	variance introduced by outliers: 19% (moderately inflated)

	benchmarking ffi single
	time                 667.9 ms   (663.7 ms .. 672.4 ms)
		       1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 673.8 ms   (670.9 ms .. 676.2 ms)
	std dev              3.076 ms   (1.877 ms .. 4.126 ms)
	variance introduced by outliers: 19% (moderately inflated)

	$ cd rust; cargo +nightly bench; cd ..
	running 3 tests
	test tests::bench_cuncurrent4 ... bench:  53,888,661 ns/iter (+/- 4,632,609)
	test tests::bench_cuncurrent8 ... bench:  55,769,549 ns/iter (+/- 3,299,461)
	test tests::bench_single      ... bench: 107,007,353 ns/iter (+/- 2,192,505)

	test result: ok. 0 passed; 0 failed; 0 ignored; 3 measured; 0 filtered out

testing on AMD FX-8350 8-core:

	$ cat /proc/cpuinfo
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor

	$ cd c; make; ./test; ./test_noopt; ./forking 8
	single avg 0.07799
	multi avg 0.07578

	single avg 0.29753
	multi avg 0.05664

	workers 8
	multi avg 0.07611, 3.141593

	$ cd haskell; stack bench
	threads avaialble: 8
	benchmarking idiomatic fork 8
	time                 47.11 ms   (45.78 ms .. 47.95 ms)
			     0.999 R²   (0.997 R² .. 1.000 R²)
	mean                 48.51 ms   (47.87 ms .. 50.15 ms)
	std dev              2.128 ms   (502.1 μs .. 3.698 ms)
	variance introduced by outliers: 14% (moderately inflated)

	benchmarking ffi fork 8
	time                 73.97 ms   (72.91 ms .. 74.90 ms)
			     0.999 R²   (0.998 R² .. 1.000 R²)
	mean                 74.69 ms   (74.02 ms .. 75.50 ms)
	std dev              1.409 ms   (892.4 μs .. 2.089 ms)

	benchmarking idiomatic async 8
	time                 46.35 ms   (45.68 ms .. 46.95 ms)
			     1.000 R²   (0.999 R² .. 1.000 R²)
	mean                 46.57 ms   (46.21 ms .. 46.96 ms)
	std dev              767.8 μs   (527.9 μs .. 1.155 ms)

	benchmarking ffi async 8
	time                 45.99 ms   (44.93 ms .. 47.27 ms)
			     0.999 R²   (0.998 R² .. 1.000 R²)
	mean                 48.00 ms   (47.33 ms .. 48.73 ms)
	std dev              1.393 ms   (893.2 μs .. 1.965 ms)

	benchmarking idiomatic parallel 8
	time                 57.63 ms   (56.52 ms .. 59.17 ms)
			     0.998 R²   (0.994 R² .. 1.000 R²)
	mean                 58.41 ms   (57.68 ms .. 59.55 ms)
	std dev              1.546 ms   (1.289 ms .. 1.914 ms)

	benchmarking ffi parallel 8
	time                 68.59 ms   (61.90 ms .. 74.05 ms)
			     0.989 R²   (0.979 R² .. 0.998 R²)
	mean                 68.28 ms   (65.83 ms .. 70.38 ms)
	std dev              3.879 ms   (2.914 ms .. 5.119 ms)
	variance introduced by outliers: 17% (moderately inflated)

	benchmarking idiomatic single
	time                 344.2 ms   (343.3 ms .. 345.1 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 344.3 ms   (344.1 ms .. 344.5 ms)
	std dev              226.6 μs   (153.7 μs .. 276.8 μs)
	variance introduced by outliers: 19% (moderately inflated)

	benchmarking ffi single
	time                 343.8 ms   (342.2 ms .. 345.2 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 346.1 ms   (345.0 ms .. 347.5 ms)
	std dev              1.401 ms   (505.2 μs .. 1.903 ms)
	variance introduced by outliers: 19% (moderately inflated)


	$ cd rust; cargo +nightly bench
	running 3 tests
	test tests::bench_cuncurrent4 ... bench:  62,867,011 ns/iter (+/- 6,838,079)
	test tests::bench_cuncurrent8 ... bench:  46,091,022 ns/iter (+/- 507,185)
	test tests::bench_single      ... bench: 191,944,004 ns/iter (+/- 6,450,561)

	test result: ok. 0 passed; 0 failed; 0 ignored; 3 measured; 0 filtered out

