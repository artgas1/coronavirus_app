//
//  UIViewExtension.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

extension UILabel {
//    func fadeIn(duration: CGFloat, delay: CGFloat) {
//        self.isHidden = false
//        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: UIView.AnimationOptions.curveEaseIn, animations: {
//            self.alpha = 1.0
//        })
//    }
    
    func fadeOut(duration: CGFloat, delay: CGFloat, completed: @escaping () -> Void) {
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (_) in
            completed()
        }
    }
    
    func floatAway(offsetX: Int, offsetY: Int, duration: CGFloat, delay: CGFloat, completed: @escaping () -> Void) {
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.center = CGPoint(x: Int(self.center.x) - offsetX, y: Int(self.center.y) - offsetY)
            self.font = UIFont(name: "Bungee-Regular", size: 24)
            self.alpha = 0.0
        }) { (_) in
            completed()
        }
    }
}
