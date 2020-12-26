import Foundation

/*
 closure(クロージャ)
 */

//((String?) -> Void)?というクロージャ型の変数closureを用意
//初期値はnil
var closure: ((String?) -> Void)? = nil

//closureに何も代入されてないので何もしない
print("------ nilなclosureを実行 closure?(\"aaa\") ------")
closure?("aaa")
print("\n\n")

//無名関数を代入
closure = { (value: String?) -> Void  in
    guard let _value = value else {
        return
    }
    print("closure : \(_value)")
}

//無名関数の中身が実行される
print("------ 無名関数代入済みclosureを実行 closure?(\"aaa\") ------")
closure?("aaa")
print("\n\n")

//クロージャーを引数に取るapi関数
//completionは「この関数が終わったら最後に実行するクロージャー」という意味だが
//言語仕様ではなく、なんとなく通例でみんながそういう名前を使うようになった
//callbackと書く人もいる
func api(endpoint:String, completion: ( (String?) -> Void )? ){
    /*
     apiの処理
     */

    print("[1]   apiの通信中3sec待ってね")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        print("[2]   apiの通信終了")
        print("\n\n")
        print("\(endpoint)")
        //通信結果を仮に乱数で0か１とする 0なら通信失敗
        let response = Int.random(in: 0...1)

        if response == 0 {
            completion?("error")
        } else {
            completion?("success")
        }
    }
}

print("---- api(endpoint:\"https://like\", completion: nil) ---")
api(endpoint:"https://like", completion: nil)
print("[3] finish")


//クロージャを引数に代入してapi関数を実行
print("---- api(endpoint:\"https://block\", completion: closure) ---")
api(endpoint:"https://block", completion: closure)
print("[3] finish")

//わざわざ無名関数を引数に代入するのがめんどうなときは直接書く
print("---- api(endpoint:\"https://comment\", completion: /*直接書いた無名関数*/) ---")
api(endpoint:"https://comment", completion: { (value: String?) -> Void  in
    guard let _value = value else {
        return
    }
    print("無名関数を直接書いたよ : \(_value)")
})
print("[3] finish")


//completionに無名関数を入れる時には省略記法がある、この書き方がもっとも一般的
print("---- api(endpoint:\"https://comment\"){  } ---")
api(endpoint: "https://comment") { (value: String?) in
    guard let _value = value else {
        return
    }
    print("無名関数を直接書いたよ : \(_value)")
}
print("[3] finish")





//api関数は無名関数を引数にとるので普通の関数だって引数として使える
func method(rtn: String?){
    guard let _value = rtn else {
        return
    }
    print("method : \(_value)")
}

print("---- api(endpoint:\"https://login\", completion: method(rtn:)) ---")
api(endpoint:"https://login", completion: method(rtn:))
print("[3] finish")
