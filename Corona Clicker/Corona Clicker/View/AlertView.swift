//
//  AlertView.swift
//  Corona Clicker
//
//  Created by Georg on 20.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    private var radius: Double
    private var transparency: CGFloat
    private var backgroud: UIColor
    
    init(frame: CGRect, center: CGPoint, radius: Double, transparency: CGFloat, background: UIColor) {
        self.radius = radius
        self.transparency = transparency
        self.backgroud = background
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.center = center
        self.cornerRadius = radius
        self.backgroundColor = backgroud
        self.alpha = transparency
    }
    
    func addShadow() {
        self.shadowColor = .black
        self.shadowOpacity = 0.4
    }
    
    public func appear(duration: Double, offsetY: CGFloat, completion: @escaping () -> Void) {
        UIView.transition(with: self, duration: duration, options: [.transitionFlipFromTop], animations: {
            self.isHidden = false
            self.center = CGPoint(x: self.center.x, y: self.center.y + offsetY)
        }) { (success) in
            completion()
        }
    }
}
