import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let disposedBag = DisposeBag()

let number = Observable.from([1,2,3,4,5])
let subscription: () = number.subscribe { event in
    print(event * 5)
}.disposed(by: disposedBag)
