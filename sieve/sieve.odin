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
init_flags :: proc(flags: []bool) {
    for i := 0; i < len(flags); i += 1 {
        flags[i] = true
    }
}

// 0と1を非素数としてマーク
mark_non_primes :: proc(flags: []bool) {
    if len(flags) > 0 {
        flags[0] = false
    }
    if len(flags) > 1 {
        flags[1] = false
    }
}

// ふるい処理 - 素数の倍数を除外
apply_sieve :: proc(flags: []bool, n: int) {
    for i := 2; i * i <= n; i += 1 {
        if flags[i] {
            mark_multiples(flags[:], i, n)
        }
    }
}

// iの倍数を全てfalseにする
mark_multiples :: proc(flags: []bool, i: int, n: int) {
    for j := i * i; j <= n; j += i {
        flags[j] = false
    }
}

// 素数を動的配列に収集
collect_primes :: proc(flags: []bool, n: int) -> [dynamic]int {
    // 動的配列の宣言（空の状態で開始）
    // append()で要素を追加していく
    primes: [dynamic]int
    for i := 2; i <= n; i += 1 {
        if flags[i] {
            // append(&primes, i) - 動的配列に要素を追加
            // 第1引数はポインタ（&）で渡す
            append(&primes, i)
        }
    }
    return primes
}
