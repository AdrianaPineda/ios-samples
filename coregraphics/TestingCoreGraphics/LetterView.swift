//
//  LetterView.swift
//  TestingCoreGraphics
//
//  Created by Adriana Pineda on 8/10/16.
//  Copyright © 2016 Adriana. All rights reserved.
//

import UIKit

@IBDesignable
class LetterView: UILabel {

    // Source http://stackoverflow.com/a/18830509/4196117

    let fillColor = UIColor.grayColor()

    override func drawRect(rect: CGRect) {
        // Drawing code

        // Draw circle
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()

        // Draw letter
//        let context = UIGraphicsGetCurrentContext()

        let gLetter = "F"

        let labelForLetter = UILabel(frame: CGRectMake(0, 0, rect.width, rect.height))
        labelForLetter.text = gLetter
        labelForLetter.font = UIFont.boldSystemFontOfSize(55)
        labelForLetter.adjustsFontSizeToFitWidth = true
        labelForLetter.textAlignment = NSTextAlignment.Center
        labelForLetter.textColor = UIColor.whiteColor()

        labelForLetter.drawTextInRect(rect)
//        labelForLetter.layer.drawInContext(context!)

    }

}
