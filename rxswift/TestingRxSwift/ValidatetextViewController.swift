//
//  ValidatetextViewController.swift
//  TestingRxSwift
//
//  Created by Adriana Pineda on 4/14/17.
//  Copyright © 2017 Adriana Pineda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ValidatetextViewController: UIViewController {

    var disposeBag = DisposeBag()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validate: UIButton!

    @IBOutlet weak var nameValidLabel: UILabel!

    @IBOutlet weak var passwordValidLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nameIsValid = nameTextField.rx.text.orEmpty
            .map { $0.characters.count > 5 }
            .shareReplay(1)

        let passwordIsValid = passwordTextField.rx.text.orEmpty
            .map { $0.characters.count > 5 }
            .shareReplay(1)

        let everythingIsValid = Observable.combineLatest(nameIsValid, passwordIsValid) { $0 && $1 }
            .shareReplay(1)

        nameIsValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)

        nameIsValid
            .bind(to: nameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)

        passwordIsValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everythingIsValid
            .bind(to: validate.rx.isEnabled)
            .disposed(by: disposeBag)

        validate.rx.tap
            .subscribe(onNext: { [weak self] in self?.showAlert() })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAlert() {

        let alert = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )

        alert.show()
    }

}
