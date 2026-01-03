package main

import "core:fmt"

// エラトステネスのふるい - n以下の素数を求める
// 戻り値: [dynamic]int - 動的配列
//   - サイズが実行時に変わる配列（C++のvector、RustのVec相当）
//   - 呼び出し側でdelete()による解放が必要
sieve_of_eratosthenes :: proc(n: int) -> [dynamic]int {
    // make([]bool, n+1) - スライスをヒープに確保
    // 配列長はn+1（インデックス0〜nにアクセスするため）
    is_prime := make([]bool, n + 1)
    // defer - 関数終了時に自動実行される遅延処理
    // returnやエラー時も確実に実行され、リソース解放忘れを防ぐ
    // 複数のdeferはLIFO（後入れ先出し）順で実行
    defer delete(is_prime)

    // 全てtrueで初期化
    for i := 0; i <= n; i += 1 {
        is_prime[i] = true
    }

    // 0と1は素数ではない
    is_prime[0] = false
    if n >= 1 {
        is_prime[1] = false
    }

    // ふるい処理
    for i := 2; i * i <= n; i += 1 {
        if is_prime[i] {
            // iの倍数を全てfalseにする
            for j := i * i; j <= n; j += i {
                is_prime[j] = false
            }
        }
    }

    // 動的配列の宣言（空の状態で開始）
    // append()で要素を追加していく
    primes: [dynamic]int
    for i := 2; i <= n; i += 1 {
        if is_prime[i] {
            // append(&primes, i) - 動的配列に要素を追加
            // 第1引数はポインタ（&）で渡す
            append(&primes, i)
        }
    }

    return primes
}

// エラトステネスのふるいを実行してデモ表示
run_sieve_demo :: proc() {
    limit := 100
    primes := sieve_of_eratosthenes(limit)
    defer delete(primes)

    fmt.printfln("Prime numbers up to %d:", limit)
    fmt.printfln("Count: %d", len(primes))
    fmt.printfln("Primes: %v", primes[:])
}
