//
//  UIVCExtension.swift
//  Corona Clicker
//
//  Created by Georg on 20.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showUpperAlert(title: String, text: String, countdown: Double) {
        let width:CGFloat = screenWidth - 2 * xConstraint
        let height: CGFloat = 128
        let frame = CGRect(x: xConstraint, y: 0, width: width, height: height)
        let color = #colorLiteral(red: 0.05091900378, green: 0.07848060876, blue: 0.1187762991, alpha: 1)
        
        let alert = AlertView(frame: frame, countdown: countdown, radius: 5.0, transpernecy: 0.95, background: color)
        self.view.addSubview(alert)
        alert.addTitle(title: title)
        alert.addText(text: text)
        alert.appear()
    }
    var screenWidth: CGFloat {
        return self.view.frame.width
    }
    
    var xConstraint: CGFloat {
        return 16.0
    }
}

