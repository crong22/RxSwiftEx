//
//  numberViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class numberViewController : UIViewController {
    
    let numFirstTextField : UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(ciColor: .cyan).cgColor
        return field
    }()
    let numTwoTextField : UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(ciColor: .cyan).cgColor
        return field
    }()
    let numThreeTextField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(ciColor: .cyan).cgColor
        return field
    }()
    let resultLabel = UILabel()
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
//        nunSumzip()
        nunSumcombine()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        resultLabel.backgroundColor = .cyan
        
        view.addSubview(numFirstTextField)
        numFirstTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(50)
        }
        
        view.addSubview(numTwoTextField)
        numTwoTextField.snp.makeConstraints { make in
            make.top.equalTo(numFirstTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(50)
        }
        
        view.addSubview(numThreeTextField)
        numThreeTextField.snp.makeConstraints { make in
            make.top.equalTo(numTwoTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(50)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(numThreeTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(50)
        }
    }
    
    
    // zip의 경우 모든 값이 충족되었을 때, 결과가 나온다.
    // 문제점 : 값을 수정하면 변화가없다, 다시 첫번 째 숫자부터 수정하면 값이 이상함..
    
    private func nunSumzip() {
        
        // 1.
        
//        Observable.zip(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty ) {one,two,three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//            .map { $0.description }
//            .subscribe(onNext: { value in
//                self.resultLabel.text = "\(value)"
//            }, onError: { error in
//                print("error : \(error)")
//            }, onCompleted: {
//                print("complete")
//            }, onDisposed: {
//                print("dispose")
//            })
//            .disposed(by: disposebag)
        
        // 2. eeror / completed 삭제
        
//        Observable.zip(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty ) {one,two,three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//            .map { $0.description }
//            .subscribe(onNext: { value in
//                self.resultLabel.text = "\(value)"
//            }, onDisposed: {
//                print("dispose")
//            })
//            .disposed(by: disposebag)
        
        
        // 3.
        
//        Observable.zip(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty ) {one,two,three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//            .map { $0.description }
//            .subscribe(onNext: {[weak self] value in
//                self?.resultLabel.text = "\(value)"
//            }, onDisposed: {
//                print("dispose")
//            })
//            .disposed(by: disposebag)
        
        // 4. 오류발생 ?
        
//        Observable
//            .zip(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty ) {one,two,three -> Int in
//                return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//            }
//            .withUnretained(self)
//            .map { $0.description }
//            .subscribe(onNext: {value in
//                self.resultLabel.text = "\(value)"
//            }, onDisposed: {
//                print("dispose")
//            })
//            .disposed(by: disposebag)
        
        // 5.
        
        Observable.zip(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty ) {one,two,three -> Int in
            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposebag)
        
    }
    
    // 명시적으로 타입 지정을해 다른사람이 봐도 타입을 알 수 있음
    private func nunSumcombine() {
        
        
//        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//        .map { $0.description }
//        .subscribe { value in
//            self.resultLabel.text = value
//        } onError: { error in
//            print("error")
//        } onCompleted: {
//            print("onCompleted")
//        } onDisposed: {
//            print("onDisposed")
//        }
//        .disposed(by: disposebag)
        
        
//        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//        .map { $0.description }
//        .subscribe { value in
//            self.resultLabel.text = value
//        } onDisposed: {
//            print("onDisposed")
//        }
//        .disposed(by: disposebag)
//        

        
        // 강한참조를 피해 메모리 누수 방지 !
        
//        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//        .map { $0.description }
//        .subscribe {[weak self] value in
//            self?.resultLabel.text = value
//        } onDisposed: {
//            print("onDisposed")
//        }
//        .disposed(by: disposebag)
        
        
        
        // subscribe : 백그라운드 쓰레드에서도 동작할 수 있다. 쓰레드 상관없음 (항상 메인쓰레드에서 동작하는 건 아니다)
        
//        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//        .map { $0.description }
//        .subscribe(with: self, onNext: { owner, value in
//            owner.resultLabel.text = value
//        }, onDisposed: { owner in
//            print("onDisposed")
//        })
//        .disposed(by: disposebag)
        
        
        
        
        // .observe(on: MainScheduler.instance) 추가
        
//        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//        .observe(on: MainScheduler.instance)
//        .map { $0.description }
//        .subscribe(with: self, onNext: { owner, value in
//            owner.resultLabel.text = value
//        }, onDisposed: { owner in
//            print("onDisposed")
//        })
//        .disposed(by: disposebag)
        
        
        
        // 메인쓰레드로 전제로 동작  + error 안받는 것
        
//        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
//            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
//        }
//        .map { $0.description }
//        .bind(with: self, onNext: { owner, value in
//            owner.resultLabel.text = value
//        })
//        .disposed(by: disposebag)
        
 
        Observable.combineLatest(numFirstTextField.rx.text.orEmpty, numTwoTextField.rx.text.orEmpty, numThreeTextField.rx.text.orEmpty) { one, two, three -> Int in
            return (Int(one) ?? 0) + (Int(two) ?? 0) + (Int(three) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposebag)
                    
                    
    }
    
    
}
