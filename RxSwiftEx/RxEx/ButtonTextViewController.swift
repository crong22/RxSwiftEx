//
//  ButtonTextViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ButtonTextViewController : UIViewController {
    
    let nameTextField : UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        return text
    }()
    let emailTextField : UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        return text
    }()
    
    let textLabel = UILabel()
    
    let signButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        signRx()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.height.equalTo(35)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.height.equalTo(35)
        }
        
        view.addSubview(textLabel)
        textLabel.textAlignment = .center
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(35)
        }
        
        view.addSubview(signButton)
        signButton.backgroundColor = .systemMint
        signButton.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.height.equalTo(45)
        }
    }
    
    private func signRx() {
        
        Observable.combineLatest(nameTextField.rx.text.orEmpty, emailTextField.rx.text.orEmpty) { name, email in
            return "name은 \(name)이고, 이메일은 \(email)입니다."
        }
        .bind(to: textLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        nameTextField.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: emailTextField.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe { _ in
                self.showAlert()
            }
            .disposed(by: disposeBag)

    }
    
    private func showAlert() {
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
}
