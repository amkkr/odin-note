package main

import "core:fmt"

main :: proc() {
    fmt.println("Hello, Odin!")

    // エラトステネスのふるいのデモ
    run_sieve_demo()


    // boolean - 真偽値型
    // bool: プラットフォーム依存（通常1byte）
    // b8/b16/b32/b64: 明示的なサイズ指定のbool型
    bool_val: bool = true
    b8_val: b8 = true
    b16_val: b16 = false
    b32_val: b32 = true
    b64_val: b64 = false
    fmt.printfln("bool: %v (%d bytes)", bool_val, size_of(bool))
    fmt.printfln("b8:   %v (%d bytes)", b8_val, size_of(b8))
    fmt.printfln("b16:  %v (%d bytes)", b16_val, size_of(b16))
    fmt.printfln("b32:  %v (%d bytes)", b32_val, size_of(b32))
    fmt.printfln("b64:  %v (%d bytes)", b64_val, size_of(b64))

    // signed integers - 符号付き整数
    // int: プラットフォーム依存（32bit/64bit環境で異なる）
    // i8〜i128: 明示的なビット数指定の符号付き整数
    int_val: int = -100
    i8_val: i8 = -128
    i16_val: i16 = -32768
    i32_val: i32 = -2147483648
    i64_val: i64 = -9223372036854775808
    i128_val: i128 = -170141183460469231731687303715884105728
    fmt.printfln("int:  %v (%d bytes)", int_val, size_of(int))
    fmt.printfln("i8:   %v (%d bytes)", i8_val, size_of(i8))
    fmt.printfln("i16:  %v (%d bytes)", i16_val, size_of(i16))
    fmt.printfln("i32:  %v (%d bytes)", i32_val, size_of(i32))
    fmt.printfln("i64:  %v (%d bytes)", i64_val, size_of(i64))
    fmt.printfln("i128: %v (%d bytes)", i128_val, size_of(i128))

    // unsigned integers - 符号なし整数
    // uint: プラットフォーム依存
    // u8〜u128: 明示的なビット数指定の符号なし整数
    // uintptr: ポインタを格納できるサイズの符号なし整数
    uint_val: uint = 100
    u8_val: u8 = 255
    u16_val: u16 = 65535
    u32_val: u32 = 4294967295
    u64_val: u64 = 18446744073709551615
    u128_val: u128 = 340282366920938463463374607431768211455
    uintptr_val: uintptr = 0xDEADBEEF
    fmt.printfln("uint:    %v (%d bytes)", uint_val, size_of(uint))
    fmt.printfln("u8:      %v (%d bytes)", u8_val, size_of(u8))
    fmt.printfln("u16:     %v (%d bytes)", u16_val, size_of(u16))
    fmt.printfln("u32:     %v (%d bytes)", u32_val, size_of(u32))
    fmt.printfln("u64:     %v (%d bytes)", u64_val, size_of(u64))
    fmt.printfln("u128:    %v (%d bytes)", u128_val, size_of(u128))
    fmt.printfln("uintptr: %v (%d bytes)", uintptr_val, size_of(uintptr))

    // complex numbers - 複素数型
    // 実部(real)と虚部(imaginary)の2つの浮動小数点数で構成
    // complex32:  f16 × 2 (2+2 bytes)
    // complex64:  f32 × 2 (4+4 bytes)
    // complex128: f64 × 2 (8+8 bytes)
    c32_val: complex32 = complex(f16(1.0), f16(2.0))
    c64_val: complex64 = 3.0 + 4.0i
    c128_val: complex128 = 5.0 + 6.0i
    fmt.printfln("complex32:  %v (%d bytes)", c32_val, size_of(complex32))
    fmt.printfln("complex64:  %v (%d bytes)", c64_val, size_of(complex64))
    fmt.printfln("complex128: %v (%d bytes)", c128_val, size_of(complex128))

    // quaternion numbers - 四元数型
    // 3D回転などに使用される4成分の数（w, x, y, z）
    // quaternion64:  f16 × 4
    // quaternion128: f32 × 4
    // quaternion256: f64 × 4
    q64_val: quaternion64 = quaternion(w = f16(1.0), x = f16(0.0), y = f16(0.0), z = f16(0.0))
    q128_val: quaternion128 = quaternion(w = f32(1.0), x = f32(0.0), y = f32(0.0), z = f32(0.0))
    q256_val: quaternion256 = quaternion(w = f64(1.0), x = f64(0.0), y = f64(0.0), z = f64(0.0))
    fmt.printfln("quaternion64:  %v (%d bytes)", q64_val, size_of(quaternion64))
    fmt.printfln("quaternion128: %v (%d bytes)", q128_val, size_of(quaternion128))
    fmt.printfln("quaternion256: %v (%d bytes)", q256_val, size_of(quaternion256))

    // rune - Unicode code point
    // 符号付き32bit整数だがi32とは別の型
    // 1つのUnicode文字を表す
    rune_val: rune = 'あ'
    fmt.printfln("rune: %c (%v) (%d bytes)", rune_val, rune_val, size_of(rune))

    // strings - 文字列型
    // string: ポインタ + 長さ（fat pointer）
    // cstring: C言語互換のnull終端文字列へのポインタ
    str_val: string = "Hello, Odin!"
    cstr_val: cstring = "C string"
    fmt.printfln("string:  %v (%d bytes)", str_val, size_of(string))
    fmt.printfln("cstring: %v (%d bytes)", cstr_val, size_of(cstring))

    // raw pointer - 生ポインタ
    // 型情報を持たない汎用ポインタ（C言語のvoid*相当）
    x := 42
    rawptr_val: rawptr = &x
    fmt.printfln("rawptr: %v (%d bytes)", rawptr_val, size_of(rawptr))

    // runtime type information - 実行時型情報
    // typeid: 型を識別するためのID
    // any: 任意の型の値を格納できる（ポインタ + typeid）
    typeid_val: typeid = typeid_of(type_of(x))
    any_val: any = x
    fmt.printfln("typeid: %v (%d bytes)", typeid_val, size_of(typeid))
    fmt.printfln("any:    %v (%d bytes)", any_val, size_of(any))
}
