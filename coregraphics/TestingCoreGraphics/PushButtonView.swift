//
//  PushButtonView.swift
//  TestingCoreGraphics
//
//  Created by Adriana Pineda on 7/31/16.
//  Copyright © 2016 Adriana. All rights reserved.
//

import UIKit

@IBDesignable
class PushButtonView: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true

    override func drawRect(rect: CGRect) {

        // Draw circle
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()

        // Draw plus sign (horizontal)
        let plusTickness: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height)*0.6

        let plusPath = UIBezierPath()
        plusPath.lineWidth = plusTickness

        plusPath.moveToPoint(CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))

        plusPath.addLineToPoint(CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))

        if isAddButton {
            // Draw plus sign (vertical)
            plusPath.moveToPoint(CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 - plusWidth/2 + 0.5))

            plusPath.addLineToPoint(CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))

        }

        UIColor.whiteColor().setStroke()
        plusPath.stroke()
    }

}
