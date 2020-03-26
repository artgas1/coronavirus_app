//
//  GameVC+UI.swift
//  Corona Clicker
//
//  Created by Georg on 26.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

extension GameVC {
    
    func setupUI() {
        multiplyer.text = "X1"
        tapCounter.text = "\(counter) INFECTED"
        tapSpeed.text = "0.0 people per second"
        menuBtn.titleLabel?.font = UIFont(name: "Bungee-Regular", size: 24)
        progressLabel.text = "0/\(goal)"
        if !DataService.isFirstLaunch { callToAction.text = "Tap to continue" }
    }
    
    func changeAppearence() {
        let duration: CGFloat = 0.2
        let delay: CGFloat = 0.2
        
        gameTitle.fadeOut(duration: duration, delay: delay) {
            self.gameTitle.removeFromSuperview()
        }
        gameSubtitle.fadeOut(duration: duration, delay: delay) {
            self.gameSubtitle.removeFromSuperview()
        }
        callToAction.fadeOut(duration: duration, delay: delay) {
            self.callToAction.removeFromSuperview()
        }
        
        tapCounter.fadeIn(duration: duration, delay: delay)
        tapSpeed.fadeIn(duration: duration, delay: delay)
        multiplyerTitle.fadeIn(duration: duration, delay: delay)
        multiplyer.fadeIn(duration: duration, delay: delay)
        menuBtn.fadeIn(duration: duration, delay: delay)
        progressBar.fadeIn(duration: duration, delay: delay)
        progressLabel.fadeIn(duration: duration, delay: delay)
    }
    
    func updateRadialGradient() {
        let frame = self.view.frame
        radialGradient.frame = frame
        radialGradient.center = self.view.center
        radialGradient.colors = [.red, .clear]
        radialGradient.radius = 256.0
        self.view.addSubview(radialGradient)
        self.view.sendSubviewToBack(radialGradient)
    }
    
    func counterTextOutputs(counter: Int) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        label.center = CGPoint(x: labelX, y: labelY)
        label.font = UIFont(name: "Bungee-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "+\(counter)"
        self.view.addSubview(label)
        label.floatAway(offsetX: textOffsetX, offsetY: textOffsetY, duration: textDuration, delay: textDelay) {
            label.removeFromSuperview()
        }
    }
    
    var labelX: Int {
        return Int(virusImage.frame.origin.x) + 36 + Int(arc4random()) % (Int(virusImage.frame.height) - 64)
    }
    
    var labelY: Int {
        return Int(virusImage.frame.origin.y) + 36 + Int(arc4random()) % (Int(virusImage.frame.width) - 64)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
