package sieve

import "core:testing"

@(test)
test_eratosthenes_10 :: proc(t: ^testing.T) {
    primes := eratosthenes(10)
    defer delete(primes)

    expected := [?]int{2, 3, 5, 7}
    testing.expect_value(t, len(primes), len(expected))

    for i := 0; i < len(expected); i += 1 {
        testing.expect_value(t, primes[i], expected[i])
    }
}

@(test)
test_eratosthenes_100 :: proc(t: ^testing.T) {
    primes := eratosthenes(100)
    defer delete(primes)

    // 100以下の素数は25個
    testing.expect_value(t, len(primes), 25)

    // 最初と最後を確認
    testing.expect_value(t, primes[0], 2)
    testing.expect_value(t, primes[24], 97)
}

@(test)
test_eratosthenes_0 :: proc(t: ^testing.T) {
    primes := eratosthenes(0)
    defer delete(primes)

    testing.expect_value(t, len(primes), 0)
}

@(test)
test_eratosthenes_1 :: proc(t: ^testing.T) {
    primes := eratosthenes(1)
    defer delete(primes)

    testing.expect_value(t, len(primes), 0)
}

@(test)
test_eratosthenes_2 :: proc(t: ^testing.T) {
    primes := eratosthenes(2)
    defer delete(primes)

    testing.expect_value(t, len(primes), 1)
    testing.expect_value(t, primes[0], 2)
}

@(test)
test_init_flags :: proc(t: ^testing.T) {
    flags := make([]bool, 5)
    defer delete(flags)

    init_flags(flags)

    for i := 0; i < len(flags); i += 1 {
        testing.expect_value(t, flags[i], true)
    }
}

@(test)
test_mark_non_primes :: proc(t: ^testing.T) {
    flags := make([]bool, 5)
    defer delete(flags)

    init_flags(flags)
    mark_non_primes(flags)

    testing.expect_value(t, flags[0], false)
    testing.expect_value(t, flags[1], false)
    testing.expect_value(t, flags[2], true)
}

@(test)
test_mark_multiples :: proc(t: ^testing.T) {
    flags := make([]bool, 11)
    defer delete(flags)

    init_flags(flags)
    mark_multiples(flags, 2, 10)

    // 2の倍数（4, 6, 8, 10）がfalseになる
    testing.expect_value(t, flags[2], true)
    testing.expect_value(t, flags[4], false)
    testing.expect_value(t, flags[6], false)
    testing.expect_value(t, flags[8], false)
    testing.expect_value(t, flags[10], false)
}

@(test)
test_collect_primes :: proc(t: ^testing.T) {
    flags := []bool{false, false, true, true, false, true}
    primes := collect_primes(flags, 5)
    defer delete(primes)

    testing.expect_value(t, len(primes), 3)
    testing.expect_value(t, primes[0], 2)
    testing.expect_value(t, primes[1], 3)
    testing.expect_value(t, primes[2], 5)
}
