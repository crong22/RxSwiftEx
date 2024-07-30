//
//  SimplePickerViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimplePickerViewController : UIViewController {
    
    let pickerOneView = UIPickerView()
    let pickerTwoView = UIPickerView()
    let pickerThreeView = UIPickerView()
    
    let disposebag = DisposeBag()
    let list = ["jack", "Den", "Bran", "Hue"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        rxpicker()
        rxColorPicker()
        colorPicker()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(pickerOneView)
        pickerOneView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)

        }
        
        view.addSubview(pickerTwoView)
        pickerTwoView.snp.makeConstraints { make in
            make.top.equalTo(pickerOneView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)

        }
        
        view.addSubview(pickerThreeView)
        pickerThreeView.snp.makeConstraints { make in
            make.top.equalTo(pickerTwoView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)

        }
    }
    
    private func rxpicker() {

        Observable.just(list)
            .bind(to: pickerOneView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposebag)

//        pickerOneView.rx.modelSelected(String.self)
//            .subscribe(onNext: { models in
//                print("1: \(models)")
//            })
//            .disposed(by: disposebag)
        
    }
    
    private func rxColorPicker() {
        Observable.just(list)
            .bind(to: pickerTwoView.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposebag)

//        pickerTwoView.rx.modelSelected(String.self)
//            .subscribe(onNext: { models in
//                print("2: \(models)")
//            })
//            .disposed(by: disposebag)
    }
    
    
    private func colorPicker() {
        Observable.just([UIColor.red, UIColor.green, UIColor.blue, UIColor.orange])
            .bind(to: pickerThreeView.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposebag)

        pickerThreeView.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("3: \(models)")
            })
            .disposed(by: disposebag)
    }
    
}
