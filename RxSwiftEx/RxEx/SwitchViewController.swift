//
//  SwitchViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SwitchViewController : UIViewController {
    
    let switchUIex = UISwitch()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        switchex()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(switchUIex)
        switchUIex.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func switchex() {
        Observable.of(false)
            .bind(to: switchUIex.rx.isOn)
            .disposed(by: disposeBag)
    }
}
