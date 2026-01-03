package sieve

// エラトステネスのふるい - n以下の素数を求める
// 戻り値: [dynamic]int - 動的配列
//   - サイズが実行時に変わる配列（C++のvector、RustのVec相当）
//   - 呼び出し側でdelete()による解放が必要
eratosthenes :: proc(n: int) -> [dynamic]int {
    // make([]bool, n+1) - スライスをヒープに確保
    // 配列長はn+1（インデックス0〜nにアクセスするため）
    is_prime := make([]bool, n + 1)
    // defer - 関数終了時に自動実行される遅延処理
    // returnやエラー時も確実に実行され、リソース解放忘れを防ぐ
    // 複数のdeferはLIFO（後入れ先出し）順で実行
    defer delete(is_prime)

    // 全てtrueで初期化
    init_flags(is_prime[:])

    // 0と1は素数ではない
    mark_non_primes(is_prime[:])

    // ふるい処理
    apply_sieve(is_prime[:], n)

    // 素数のリストを作成
    return collect_primes(is_prime[:], n)
}

// 配列を全てtrueで初期化
@(private)
init_flags :: proc(flags: []bool) {
    for index := 0; index < len(flags); index += 1 {
        flags[index] = true
    }
}

// 0と1を非素数としてマーク
@(private)
mark_non_primes :: proc(flags: []bool) {
    if len(flags) > 0 {
        flags[0] = false
    }
    if len(flags) > 1 {
        flags[1] = false
    }
}

// ふるい処理 - 素数の倍数を除外
@(private)
apply_sieve :: proc(flags: []bool, limit: int) {
    for candidate := 2; candidate * candidate <= limit; candidate += 1 {
        if flags[candidate] {
            mark_multiples(flags[:], candidate, limit)
        }
    }
}

// primeの倍数を全てfalseにする
@(private)
mark_multiples :: proc(flags: []bool, prime: int, limit: int) {
    for multiple := prime * prime; multiple <= limit; multiple += prime {
        flags[multiple] = false
    }
}

// 素数を動的配列に収集
@(private)
collect_primes :: proc(flags: []bool, limit: int) -> [dynamic]int {
    // 動的配列の宣言（空の状態で開始）
    // append()で要素を追加していく
    primes: [dynamic]int
    for number := 2; number <= limit; number += 1 {
        if flags[number] {
            // append(&primes, number) - 動的配列に要素を追加
            // 第1引数はポインタ（&）で渡す
            append(&primes, number)
        }
    }
    return primes
}
