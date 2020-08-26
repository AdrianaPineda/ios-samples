//
//  CounterView.swift
//  TestingCoreGraphics
//
//  Created by Adriana Pineda on 7/31/16.
//  Copyright © 2016 Adriana. All rights reserved.
//

import UIKit

var countDown = 30

@IBDesignable
class CounterView: UIView {

    @IBInspectable var counter: Double = 30 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var counterColor: UIColor = UIColor.purpleColor()

    override func drawRect(rect: CGRect) {

        let path = UIBezierPath()
        path.lineWidth = 100

        path.moveToPoint(CGPoint(x: 0, y: 0))

        let counterPosition = (bounds.width/30)*CGFloat(counter)
        path.addLineToPoint(CGPoint(x: counterPosition, y: 0))

        counterColor.setStroke()
        path.stroke()


    }

}
