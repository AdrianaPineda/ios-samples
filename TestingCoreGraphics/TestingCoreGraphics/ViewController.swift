//
//  ViewController.swift
//  TestingCoreGraphics
//
//  Created by Adriana Pineda on 7/31/16.
//  Copyright © 2016 Adriana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterView: CounterView!
    var counter: Double = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func updateTimer() {

        counter -= 0.1
        if self.counter <= 0 {
            counter = 30
        }

        self.counterView.counter = counter


    }
}

