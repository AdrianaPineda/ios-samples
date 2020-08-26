//
//  SimpleTableViewController.swift
//  TestingRxSwift
//
//  Created by Adriana Pineda on 4/14/17.
//  Copyright © 2017 Adriana Pineda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)


        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { [weak self] value in
                self?.presentAlert(message: "Tapped `\(value)`")
            })
            .disposed(by: disposeBag)
    }

    func presentAlert(message: String) {
        let alertView = UIAlertController(title: "RxExample", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
        })
        self.present(alertView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
