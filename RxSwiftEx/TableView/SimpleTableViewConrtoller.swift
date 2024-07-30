//
//  SimpleTableViewConrtoller.swift
//  RxSwiftEx
//
//  Created by 여누 on 7/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewConrtoller : UIViewController {
    let tableView = UITableView()
    
    let disposeBag = DisposeBag()    
    
    let list = [Int.random(in: 0...100)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        configureUI()
        
        simpleTable()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func simpleTable() {
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        
        items
        .take(1)
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        
    }
}
