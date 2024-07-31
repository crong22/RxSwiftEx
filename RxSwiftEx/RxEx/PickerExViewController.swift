//
//  PickerExViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PickerExViewController : UIViewController {
    let pickerview = UIPickerView()
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        pickerRx()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(pickerview)
        pickerview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func pickerRx(){
        
        let items = Observable.just([
            "영화",
            "드라마",
            "애니메이션",
            "기타"
        ])
        
        items
            .bind(to: pickerview.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposebag)
    }
}
