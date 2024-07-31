//
//  TableExViewController.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TableExViewController : UIViewController {
    let simpleLabel = UILabel()
    let tableView = UITableView()
    
    let disposebag = DisposeBag()
    
    let items = Observable.just([
        "First",
        "Second",
        "Third"
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableRx()

    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(simpleLabel)
        simpleLabel.backgroundColor = .systemCyan
        simpleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func tableRx() {
        items
            .bind(to: tableView.rx.items) {(tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @row \(row)"
                return cell
            }
            .disposed(by: disposebag)
        
        selectRx()

    }
    
    private func selectRx() {
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposebag)
    }
}
