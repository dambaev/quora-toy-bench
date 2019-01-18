#![feature(test)]

use std::thread;
extern crate test;

const N:u32 = 10000000;
const H:f64 = 1.0f64 / (1.0f64 + N as f64);

fn calc_part( per_thread: u32, start: u32) -> f64{
    let mut ret:f64 = 0.0f64;
    let to = start + per_thread;
    let mut i = start;
    while i < to {
        let x = i as f64 * H;
        ret += H * ( 1.0f64 - x * x).sqrt();
        i += 1;
    }
    ret
}

fn calc_concurrent(n: u32)-> f64 {
    let mut hs = vec![];
    let per_thread: u32 = N / n;
    for i in 0..n {
        let start = i * per_thread;
        hs.push( thread::spawn( move || calc_part( per_thread, start) ));
    }
    let mut ret:f64 = 0.0f64;
    for child in hs {
        match child.join() {
            Err(_) => (),
            Ok(res) => ret += res,
        }
    }
    ret
}



#[cfg(test)]
mod tests {
    use super::*;
    use test::Bencher;

    #[bench]
    fn bench_single(b: &mut Bencher) {
        b.iter(|| calc_part( N, 0));
    }
    #[bench]
    fn bench_cuncurrent4(b: &mut Bencher) {
        b.iter(|| calc_concurrent( 4));
    }
    #[bench]
    fn bench_cuncurrent8(b: &mut Bencher) {
        b.iter(|| calc_concurrent( 8));
    }
}

fn main() {
    println!( "{}", 4.0f64 * calc_part( N, 0));

    println!( "conc1 {}", 4.0f64 * calc_concurrent( 1));
    println!( "conc2 {}", 4.0f64 * calc_concurrent( 2));
    println!( "conc3 {}", 4.0f64 * calc_concurrent( 3));
    println!( "conc4 {}", 4.0f64 * calc_concurrent( 4));
}
