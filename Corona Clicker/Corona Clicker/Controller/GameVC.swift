//
//  IntroVC.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var virus: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameSubtitle: UILabel!
    @IBOutlet weak var callToAction: UILabel!
    @IBOutlet weak var tapCounter: UILabel!
    @IBOutlet weak var tapSpeed: UILabel!
    @IBOutlet weak var multiplyerTitle: UILabel!
    @IBOutlet weak var multiplyer: UILabel!
    
    var gameStarted = false
    var counter = 0
    var runCounter: CGFloat = 0.0
    var tapsPerSec: CGFloat = 0.0
    var coeffitient = 1
    
    override func viewDidLoad() {
        multiplyer.text = "X1"
        tapCounter.text = "0 DECEASED"
        tapSpeed.text = "0.0 people per second"
        observeTaps()
        super.viewDidLoad()
    }
    
    func observeTaps() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onVirusTap))
        virus.isUserInteractionEnabled = true
        virus.addGestureRecognizer(gesture)
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
    }
    
    func startTimer() {
        let timer = Timer(timeInterval: 0.2, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func fireTimer() {
        runCounter += 0.2
        tapsPerSec = CGFloat(counter) / CGFloat(runCounter)
        tapSpeed.text = "\(tapsPerSec) people per second"
        tapSpeed.text = String(format: "%.2f people per second", tapsPerSec)
        
        if runCounter > 5.0 && tapsPerSec > 5.0 {
            coeffitient = 2
            multiplyer.text = "X\(coeffitient)"
        }
        
        if runCounter > 10.0 && tapsPerSec > 10.0 {
            coeffitient = 3
            multiplyer.text = "X\(coeffitient)"
        }
        
        if runCounter > 30.0 && tapsPerSec > 20.0 {
            coeffitient = 3
            multiplyer.text = "X\(coeffitient)"
        }
    }
    
    @objc func onVirusTap() {
        let duration: CGFloat = 0.5
        let delay: CGFloat = 0.0
        let scaleX: CGFloat = 1.08
        let scaleY: CGFloat = 1.08
        
        if !gameStarted {
            gameStarted = true
            startTimer()
            changeAppearence()
        }
        counter += 1 * coeffitient
        tapCounter.text = "\(counter) DECEASED"
        
        virus.scaleOutIn(duration: duration, delay: delay, scaleX: scaleX, scaleY: scaleY)
    }
    
}
