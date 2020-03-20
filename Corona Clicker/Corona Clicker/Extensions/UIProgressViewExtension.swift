//
//  UIProgressViewExtension.swift
//  Corona Clicker
//
//  Created by Андрей Хромов on 20.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

extension UIProgressView {
    func fadeIn(duration: CGFloat, delay: CGFloat) {
        self.isHidden = false
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        })
    }
}
