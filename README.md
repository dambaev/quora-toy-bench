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

