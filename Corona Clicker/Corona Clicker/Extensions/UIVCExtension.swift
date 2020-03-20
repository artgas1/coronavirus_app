//
//  UIVCExtension.swift
//  Corona Clicker
//
//  Created by Georg on 20.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showUpperAlert() {
        print("show upper alert")
        let width:CGFloat = screenWidth - 2 * xConstraint
        let height: CGFloat = 128
        let frame = CGRect(x: xConstraint, y: 0, width: width, height: height)
        let center = CGPoint(x: self.view.center.x, y: -128.0)
        let color = #colorLiteral(red: 0.04705882353, green: 0.06274509804, blue: 0.09019607843, alpha: 1)
        
        let duration = 0.5
        let offsetY: CGFloat = 81.0
        
        let alert = AlertView(frame: frame, center: center, radius: 5.0, transparency: 0.9, background: color)
        self.view.addSubview(alert)
        
        alert.appear(duration: duration, offsetY: offsetY) {
            self.startCountdown()
        }
    }
    
    func startCountdown() {
        print("Countdown started")
    }
    
    var screenWidth: CGFloat {
        return self.view.frame.width
    }
    
    var xConstraint: CGFloat {
        return 16.0
    }
}

