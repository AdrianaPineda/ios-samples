//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Adriana Pineda on 7/31/16.
//  Copyright © 2016 Adriana. All rights reserved.
//

import WatchKit
import Foundation

@IBDesignable
class InterfaceController: WKInterfaceController {

    var counter: Double = 30.0
    @IBOutlet var timerImage: WKInterfaceImage!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)

    }

    func configureTimerWithCounter(counter: Double) {

        let size = CGSizeMake(self.contentFrame.width, 6)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        UIGraphicsPushContext(context!)

        // Draw line
        let path = UIBezierPath()
        path.lineWidth = 100

        path.moveToPoint(CGPoint(x: 0, y: 0))

        let counterPosition = (self.contentFrame.width/30)*CGFloat(counter)
        path.addLineToPoint(CGPoint(x: counterPosition, y: 0))

        UIColor.greenColor().setStroke()
        UIColor.whiteColor().setFill()
        path.stroke()
        path.fill()

        // Convert to UIImage
        let cgimage = CGBitmapContextCreateImage(context);
        let uiimage = UIImage(CGImage: cgimage!)

        // End the graphics context
        UIGraphicsPopContext()
        UIGraphicsEndImageContext()

        self.timerImage.setImage(uiimage)

    }

    func updateTimer() {

        counter -= 0.1

        if self.counter <= 0 {
            self.counter = 30
        }

        configureTimerWithCounter(counter)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
