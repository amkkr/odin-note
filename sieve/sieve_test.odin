package sieve

import "core:slice"
import "core:testing"

// ヘルパー: 素数リストが期待値と一致するか検証
@(private)
expect_primes :: proc(t: ^testing.T, actual: [dynamic]int, expected: []int) {
    testing.expect(t, slice.equal(actual[:], expected), "primes should match expected values")
}

// 0以下の場合、素数は存在しない
@(test)
test_no_primes_exist_when_limit_is_zero :: proc(t: ^testing.T) {
    primes := eratosthenes(0)
    defer delete(primes)

    testing.expect_value(t, len(primes), 0)
}

// 1以下の場合、素数は存在しない（1は素数ではない）
@(test)
test_no_primes_exist_when_limit_is_one :: proc(t: ^testing.T) {
    primes := eratosthenes(1)
    defer delete(primes)

    testing.expect_value(t, len(primes), 0)
}

// 2は最小の素数
@(test)
test_two_is_the_smallest_prime :: proc(t: ^testing.T) {
    primes := eratosthenes(2)
    defer delete(primes)

    expect_primes(t, primes, []int{2})
}

// 10以下の素数は2, 3, 5, 7
@(test)
test_primes_up_to_ten :: proc(t: ^testing.T) {
    primes := eratosthenes(10)
    defer delete(primes)

    expect_primes(t, primes, []int{2, 3, 5, 7})
}

// 100以下の素数は25個存在し、最大は97
@(test)
test_primes_up_to_one_hundred :: proc(t: ^testing.T) {
    primes := eratosthenes(100)
    defer delete(primes)

    testing.expect_value(t, len(primes), 25)
    testing.expect_value(t, primes[0], 2)
    testing.expect_value(t, primes[len(primes) - 1], 97)
}
