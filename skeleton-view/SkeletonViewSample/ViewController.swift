//
//  ViewController.swift
//  SkeletonViewSample
//
//  Created by Adriana Pineda on 22/04/2020.
//  Copyright © 2020 Adriana Pineda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var skeletonView: UIView!

    var gradientLayer: CAGradientLayer!
    var startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    var endLocations: [NSNumber] = [1.0, 1.5, 2.0]
    var gradientBackgroundColor: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientMovingColor: CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
    var movingAnimationDuration : CFTimeInterval = 1.8
    var delayBetweenAnimationLoops : CFTimeInterval = 0.3

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = self.skeletonView.bounds
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.gradientLayer.colors = [
            self.gradientBackgroundColor,
            self.gradientMovingColor,
            self.gradientBackgroundColor
        ]
        self.gradientLayer.locations = self.startLocations
        self.skeletonView.layer.addSublayer(self.gradientLayer)
    }

    @IBAction func runAnimation(_ sender: Any) {
//        let animation = CABasicAnimation(keyPath: "locations")
//        animation.fromValue = self.startLocations
//        animation.toValue = self.endLocations
//        animation.duration = 0.8
//        animation.repeatCount = .infinity
//        self.gradientLayer.add(animation, forKey: animation.keyPath)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = self.startLocations
        animation.toValue = self.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)


        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }
}
