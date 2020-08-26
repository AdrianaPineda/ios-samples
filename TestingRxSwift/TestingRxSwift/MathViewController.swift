//
//  ViewController.swift
//  TestingRxSwift
//
//  Created by Adriana Pineda on 4/13/17.
//  Copyright © 2017 Adriana Pineda. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MathViewController: UIViewController {

    var disposeBag = DisposeBag()

    @IBOutlet weak var firstNumber: UITextField!
    @IBOutlet weak var secondNumber: UITextField!
    @IBOutlet weak var thirdNumber: UITextField!

    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.combineLatest(firstNumber.rx.text.orEmpty, secondNumber.rx.text.orEmpty, thirdNumber.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return ((Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0))
        }
        .map { $0.description } // "\($0)" also works
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
