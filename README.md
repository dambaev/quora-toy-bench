tests on lenovo thinkpad E470 with i5-7200u:
	$ cat /proc/cpuinfo
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
	model name	: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz

	$ cd c && make && ./test
	single avg 0.01017
	multi avg 0.01878

	$ cd c && ./test_noopt
	single avg 0.03356
	multi avg 0.01766

	$ cd haskell && stack bench cd ..
	threads avaialble: 4
	benchmarking idiomatic single
	time                 129.3 ms   (129.1 ms .. 129.6 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 129.5 ms   (129.4 ms .. 129.8 ms)
	std dev              337.1 μs   (112.9 μs .. 549.0 μs)
	variance introduced by outliers: 11% (moderately inflated)

	benchmarking idiomatic parallel 4
	time                 40.07 ms   (38.69 ms .. 42.13 ms)
			     0.995 R²   (0.989 R² .. 1.000 R²)
	mean                 42.08 ms   (40.29 ms .. 47.42 ms)
	std dev              6.345 ms   (1.010 ms .. 11.14 ms)
	variance introduced by outliers: 58% (severely inflated)

	benchmarking idiomatic async 4
	time                 33.63 ms   (32.98 ms .. 34.47 ms)
			     0.998 R²   (0.996 R² .. 1.000 R²)
	mean                 33.92 ms   (33.63 ms .. 34.50 ms)
	std dev              867.3 μs   (374.4 μs .. 1.429 ms)

	benchmarking ffi single
	time                 71.79 ms   (71.65 ms .. 71.88 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 71.70 ms   (71.63 ms .. 71.76 ms)
	std dev              116.0 μs   (84.88 μs .. 154.2 μs)

	benchmarking ffi parallel 4
	time                 19.00 ms   (18.60 ms .. 19.45 ms)
			     0.996 R²   (0.991 R² .. 0.999 R²)
	mean                 18.96 ms   (18.74 ms .. 19.28 ms)
	std dev              629.5 μs   (454.3 μs .. 898.7 μs)

	benchmarking ffi async 4
	time                 19.78 ms   (19.30 ms .. 20.20 ms)
			     0.996 R²   (0.992 R² .. 0.999 R²)
	mean                 19.92 ms   (19.60 ms .. 20.38 ms)
	std dev              895.2 μs   (565.7 μs .. 1.318 ms)
	variance introduced by outliers: 14% (moderately inflated)

	$ cd rust && cargo +nightly bench
	running 3 tests
	test tests::bench_cuncurrent4 ... bench:  10,702,914 ns/iter (+/- 1,285,312)
	test tests::bench_cuncurrent8 ... bench:  11,089,570 ns/iter (+/- 1,235,082)
	test tests::bench_single      ... bench:  21,433,822 ns/iter (+/- 584,496)

	test result: ok. 0 passed; 0 failed; 0 ignored; 3 measured; 0 filtered out

Tests on AMD FX-8350 8-core
	$ cat /proc/cpuinfo
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor

	$ cd c && make && ./test
	single avg 0.01596
	multi avg 0.01641

	$ cd c && ./test_noopt
	single avg 0.06115
	multi avg 0.01204

	$ cd haskell && stack bench cd ..
	threads avaialble: 8
	benchmarking idiomatic single
	time                 48.17 ms   (47.49 ms .. 48.66 ms)
			     1.000 R²   (0.999 R² .. 1.000 R²)
	mean                 47.58 ms   (47.28 ms .. 47.82 ms)
	std dev              496.8 μs   (337.0 μs .. 767.4 μs)

	benchmarking idiomatic parallel 8
	time                 33.96 ms   (31.57 ms .. 37.48 ms)
			     0.978 R²   (0.962 R² .. 0.990 R²)
	mean                 32.10 ms   (29.28 ms .. 34.27 ms)
	std dev              5.200 ms   (2.827 ms .. 7.440 ms)
	variance introduced by outliers: 63% (severely inflated)

	benchmarking idiomatic async 8
	time                 12.48 ms   (12.22 ms .. 12.77 ms)
			     0.998 R²   (0.996 R² .. 0.999 R²)
	mean                 12.35 ms   (12.20 ms .. 12.51 ms)
	std dev              415.2 μs   (335.9 μs .. 552.0 μs)
	variance introduced by outliers: 10% (moderately inflated)

	benchmarking ffi single
	time                 108.1 ms   (107.6 ms .. 108.6 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 108.2 ms   (108.0 ms .. 108.5 ms)
	std dev              366.6 μs   (202.0 μs .. 533.2 μs)

	benchmarking ffi parallel 8
	time                 19.22 ms   (18.24 ms .. 20.19 ms)
			     0.989 R²   (0.978 R² .. 0.996 R²)
	mean                 18.36 ms   (17.93 ms .. 18.86 ms)
	std dev              1.113 ms   (870.7 μs .. 1.405 ms)
	variance introduced by outliers: 26% (moderately inflated)

	benchmarking ffi async 8
	time                 20.00 ms   (19.06 ms .. 21.08 ms)
			     0.989 R²   (0.979 R² .. 0.996 R²)
	mean                 19.07 ms   (18.68 ms .. 19.54 ms)
	std dev              1.107 ms   (835.9 μs .. 1.385 ms)
	variance introduced by outliers: 22% (moderately inflated)

	$ cd rust && cargo +nightly bench
	running 3 tests
	test tests::bench_cuncurrent4 ... bench:  14,809,182 ns/iter (+/- 3,538,395)
	test tests::bench_cuncurrent8 ... bench:   9,491,672 ns/iter (+/- 782,162)
	test tests::bench_single      ... bench:  43,030,624 ns/iter (+/- 2,053,825)

	test result: ok. 0 passed; 0 failed; 0 ignored; 3 measured; 0 filtered out

