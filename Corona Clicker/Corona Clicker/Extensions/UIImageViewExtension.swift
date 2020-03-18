//
//  ImageViewExtension.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

extension UIImageView {
    func scaleOutIn(duration: CGFloat, delay: CGFloat, scaleX: CGFloat, scaleY: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

        UIView.animate(withDuration: TimeInterval(duration),
                       delay: TimeInterval(delay),
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                            self.transform = CGAffineTransform.identity
                       },
                       completion: { Void in()  })
    }
}
