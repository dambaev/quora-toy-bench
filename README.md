stats for Intel Core-i5 7200u

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

stats for AMD FX-8350

	$ cat /proc/cpuinfo | grep name
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor
	model name	: AMD FX(tm)-8350 Eight-Core Processor

	$ cd c; make; ./test; ./test_nonopt; ./forking 8; cd ..
	single avg 0.07824
	multi avg 0.07648
	single avg 0.29783
	multi avg 0.05640
	workers 8
	multi avg 0.07579, 3.141593

	$ cd haskell; stack bench; cd ..
	Benchmark first: RUNNING...
	threads avaialble: 8
	benchmarking idiomatic fork 8
	time                 47.96 ms   (47.17 ms .. 48.56 ms)
			     0.999 R²   (0.998 R² .. 1.000 R²)
	mean                 47.92 ms   (47.40 ms .. 48.49 ms)
	std dev              1.052 ms   (731.4 μs .. 1.615 ms)

	benchmarking idiomatic async 8
	time                 46.23 ms   (45.98 ms .. 46.44 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 46.92 ms   (46.61 ms .. 47.46 ms)
	std dev              808.1 μs   (400.6 μs .. 1.042 ms)

	benchmarking idiomatic parallel 8
	time                 91.83 ms   (91.43 ms .. 92.09 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 92.18 ms   (91.97 ms .. 92.52 ms)
	std dev              423.0 μs   (196.7 μs .. 581.4 μs)

	benchmarking idiomatic single
	time                 178.3 ms   (177.6 ms .. 179.2 ms)
			     1.000 R²   (1.000 R² .. 1.000 R²)
	mean                 182.6 ms   (180.9 ms .. 186.2 ms)
	std dev              3.160 ms   (890.7 μs .. 4.496 ms)
	variance introduced by outliers: 14% (moderately inflated)

	Benchmark first: FINISH

	$ cd rust; cargo +nightly bench; cd ..
	running 3 tests
	test tests::bench_cuncurrent4 ... bench:  62,799,630 ns/iter (+/- 7,472,733)
	test tests::bench_cuncurrent8 ... bench:  46,058,927 ns/iter (+/- 362,554)
	test tests::bench_single      ... bench: 195,368,513 ns/iter (+/- 7,550,516)

	test result: ok. 0 passed; 0 failed; 0 ignored; 3 measured; 0 filtered out

