//
//  validationViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class validationViewController : UIViewController {
    let nickLabel : UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    let nickTextFiled  : UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        return text
    }()
    let nickValidationLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .red
        return label
    }()
    let pwLabel : UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    let pwTextFiled : UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        return text
    }()
    let pwValidationLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .red
        return label
    }()
    let confirmButton : UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .blue
        return button
    }()
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        dovalidtion()
    }
    
    private func dovalidtion() {
        nickValidationLabel.text = "아이디는 최소 \(minimalUsernameLength) 이상 입력해주세요 :)"
        pwValidationLabel.text = "비밀번호는 최소 \(minimalPasswordLength) 이상 입력해주세요 :)"
        
        let usernameValid = nickTextFiled.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)

        let passwordValid = pwTextFiled.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: pwTextFiled.rx.isEnabled)
            .disposed(by: disposebag)

        usernameValid
            .bind(to: nickValidationLabel.rx.isHidden)
            .disposed(by: disposebag)

        passwordValid
            .bind(to: pwValidationLabel.rx.isHidden)
            .disposed(by: disposebag)

        everythingValid
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposebag)

        confirmButton.rx.tap
//            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .bind(with: self, onNext: { owner, _ in
                owner.showAlert()
            })
            .disposed(by: disposebag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "알림",
            message: "가입완료",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "가입",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

    
    private func configureUI() {
        view.backgroundColor = .white
        
    
        view.addSubview(nickLabel)
        nickLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(20)
        }
        
        view.addSubview(nickTextFiled)
        nickTextFiled.snp.makeConstraints { make in
            make.top.equalTo(nickLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(nickValidationLabel)
        nickValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(nickTextFiled.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(30)
        }
        
        view.addSubview(pwLabel)
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(nickValidationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(20)
        }
        
        view.addSubview(pwTextFiled)
        pwTextFiled.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(pwValidationLabel)
        pwValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextFiled.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(30)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(pwValidationLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(40)
        }
    }
}
