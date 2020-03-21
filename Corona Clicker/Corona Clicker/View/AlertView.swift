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
    private var background: UIColor
    private var countdown = 1.0
    
    public var offsetY: CGFloat = 81.0
    public var duration: Double = 4.0
    public var delay: Double = 0
    public var springDamping: CGFloat = 20
    public var springVelocity: CGFloat = 5
    
    init(frame: CGRect, countdown: Double, radius: Double, transpernecy: CGFloat, background: UIColor) {
        self.countdown = countdown
        self.radius = radius
        self.transparency = transpernecy
        self.background = background
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.cornerRadius = radius
        self.backgroundColor = background
        self.alpha = transparency
        addCloseGesture()
    }
    
    func addCloseGesture() {

        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(hide))
        slideUp.direction = .up
        self.addGestureRecognizer(slideUp)
    }
    
    func addShadow() {
        self.shadowColor = .black
        self.shadowOpacity = 0.4
    }
    
    public func addTitle(title: String) {
        let frame = CGRect(x: 36, y: 24, width: self.frame.width - 72, height: 24)
        let titleLabel = UILabel(frame: frame)
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Bungee-Regular", size: 20)
        titleLabel.text = title
        titleLabel.textColor = .white
        self.addSubview(titleLabel)
    }
    
    public func addText(text: String) {
        let frame = CGRect(x: 36, y: 38, width: self.frame.width - 72, height: 68)
        let textLabel = UILabel(frame: frame)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Futura-Medium", size: 16)
        textLabel.text = text
        textLabel.textColor = .white
        self.addSubview(textLabel)
    }
    
    public func appear() {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 30, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.center = CGPoint(x: self.center.x, y: self.center.y + self.offsetY)
        }, completion: { (completed) in
            self.startCountdown()
        })
    }
    
    func startCountdown() {
        let timer = Timer(timeInterval: countdown, target: self, selector: #selector(self.activateTimer), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func activateTimer() {
        self.hide()
    }
    
    @objc public func hide() {
        UIView.animate(withDuration: 0.33, delay: delay, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.center = CGPoint(x: self.center.x, y: self.center.y - self.offsetY * 3)
        }, completion: { (completed) in
            self.removeFromSuperview()
        })
    }
}
