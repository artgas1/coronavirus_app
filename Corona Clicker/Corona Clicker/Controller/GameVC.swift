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
    
    // MARK: - Stats
    var gameStarted = false
    var counter = 0
    var runCounter: CGFloat = 0.0
    var tapsPerSec: CGFloat = 0.0
    var coeffitient = 1
    
    // MARK: - Virus Animation Settings
    let duration: CGFloat = 0.5
    let delay: CGFloat = 0.0
    let scaleX: CGFloat = 1.08
    let scaleY: CGFloat = 1.08
    
    // MARK: - Text Animation Settings
    let textDuration: CGFloat = 0.6
    let textDelay: CGFloat = 0.0
    let textOffsetX: Int = 0
    let textOffsetY: Int = 128
    
    override func viewDidLoad() {
        multiplyer.text = "X1"
        tapCounter.text = "0 INFECTED"
        tapSpeed.text = "0.0 people per second"
        observeTaps()
        super.viewDidLoad()
    }
    
    // MARK: - Virus Taps
    func observeTaps() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onVirusTap))
        virus.isUserInteractionEnabled = true
        virus.addGestureRecognizer(gesture)
    }
    
    @objc func onVirusTap() {
        if !gameStarted {
            gameStarted = true
            startTimer()
            changeAppearence()
        }
        counter += 1 * coeffitient
        tapCounter.text = "\(counter) INFECTED"
        
        // MARK: - TODO: Complete Text Outputs w/ animation. Uncomment to test.
        counterTextOutputs(counter: 1*coeffitient)
        
        virus.scaleOutIn(duration: duration, delay: delay, scaleX: scaleX, scaleY: scaleY)
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
        return Int(virus.frame.origin.x) + 36 + Int(arc4random()) % (Int(virus.frame.height) - 64)
    }
    
    var labelY: Int {
        return Int(virus.frame.origin.y) + 36 + Int(arc4random()) % (Int(virus.frame.width) - 64)
    }
    
    // MARK: - On First Tap
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
    
    // MARK: - Speed Timer
    func startTimer() {
        let timer = Timer(timeInterval: 0.2, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func fireTimer() {
        runCounter += 0.2
        tapsPerSec = CGFloat(counter) / CGFloat(runCounter)
        tapSpeed.text = "\(tapsPerSec) people per second"
        tapSpeed.text = String(format: "%.2f people per second", tapsPerSec)
        
        if runCounter > 5.0 && tapsPerSec > 5.0 { coeffitient = 2 }
        if runCounter > 10.0 && tapsPerSec > 10.0 { coeffitient = 3 }
        if runCounter > 30.0 && tapsPerSec > 20.0 { coeffitient = 5 }
        
        multiplyer.text = "X\(coeffitient)"
    }
}
