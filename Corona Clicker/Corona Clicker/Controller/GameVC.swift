//
//  IntroVC.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var virusImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameSubtitle: UILabel!
    @IBOutlet weak var callToAction: UILabel!
    @IBOutlet weak var tapCounter: UILabel!
    @IBOutlet weak var tapSpeed: UILabel!
    @IBOutlet weak var multiplyerTitle: UILabel!
    @IBOutlet weak var multiplyer: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    // MARK: - Stats
    var gameStarted = false
    var runCounter: CGFloat = 0.0
    var tapsPerSec: CGFloat = 0.0
    var coeffitient = 1
    var nullCounter = 0
    var purshasedCoeffitient = 1
    
    var currentVirus: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "currentVirusDataKey")
            UserDefaults.standard.synchronize()
        }
        get{
            if let currentVirusData = UserDefaults.standard.integer(forKey: "currentVirusDataKey") as? Int {
                return currentVirusData
            }
            else {
                return 0
            }
        }
    }
    var totalGameStarted: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "gameStartedDataKey")
            UserDefaults.standard.synchronize()
        }
        get {
            if let gameStartedData = UserDefaults.standard.bool(forKey: "gameStartedDataKey") as? Bool {
                return gameStartedData
            }
            else {
                return false
            }
        }
    }
    var counter: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "counterDataKey")
            UserDefaults.standard.synchronize()
        }
        get{
            if let counterData = UserDefaults.standard.integer(forKey: "counterDataKey") as? Int{
                return counterData
            }
            else {
                return 0
            }
        }
    }
    var goal: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "goalDataKey")
            UserDefaults.standard.synchronize()
        }
        get{
            if let goalData = UserDefaults.standard.integer(forKey: "goalDataKey") as? Int{
                if goalData > 10{
                    return goalData
                }
                else {
                    return 10
                }
            }
            else {
                return 10
            }
        }
    }
    
    let worldPopulation = 7783970600
    
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
    
    var virus = DataService.viruses[DataService.currentItemID]
    
    let radialGradient = RadialGradientView()
    
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        setupUI()
        observeTaps()
        updateVirusSettings()
        updateRadialGradient()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateVirusSettings), name: .updateVirus, object: nil)
        super.viewDidLoad()
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
    
    @objc func updateVirusSettings() {
        virus = DataService.viruses[DataService.currentItemID]
        virusImage.image = virus.image
        purshasedCoeffitient = virus.contaigousness
    }
    
    func setupUI() {
        multiplyer.text = "X1"
        tapCounter.text = "\(counter) INFECTED"
        tapSpeed.text = "0.0 people per second"
        menuBtn.titleLabel?.font = UIFont(name: "Bungee-Regular", size: 24)
        progressLabel.text = "0/\(goal)"
        if totalGameStarted {callToAction.text = "Tap to continue"}
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Virus Taps
    func observeTaps() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onVirusTap))
        virusImage.isUserInteractionEnabled = true
        virusImage.addGestureRecognizer(gesture)
    }
    
    @objc func onVirusTap() {
        if !gameStarted {
            gameStarted = true
            totalGameStarted = true
            startTimer()
            changeAppearence()
        }
        counter += 1 * coeffitient
        nullCounter += 1 * coeffitient
        tapCounter.text = "\(counter) INFECTED"
        progressLabel.text = "\(counter)/\(goal)"
        progressBar.progress = Float(counter) / Float(goal)
        counterTextOutputs(counter: 1*coeffitient)
        
        if counter >= goal {
            self.showUpperAlert(title: "Fascinating!", text: "The virus is spreading rapidly! You have infected \(goal) people.", countdown: 3)
            goal *= 10
        }
        if goal >= worldPopulation {goal = worldPopulation}
        
        virusImage.scaleOutIn(duration: duration, delay: delay, scaleX: scaleX, scaleY: scaleY)
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
        menuBtn.fadeIn(duration: duration, delay: delay)
        progressBar.fadeIn(duration: duration, delay: delay)
        progressLabel.fadeIn(duration: duration, delay: delay)
    }
    
    // MARK: - Speed Timer
    func startTimer() {
        let timer = Timer(timeInterval: 0.2, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
        let perSecTimer = Timer(timeInterval: 1, target: self, selector: #selector(self.peopleCounter), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        RunLoop.current.add(perSecTimer, forMode: RunLoop.Mode.common)
    }
    
    @objc func fireTimer() {
        runCounter += 0.2
        tapSpeed.text = "\(tapsPerSec) people per second"
        tapSpeed.text = String(format: "%.2f people per second", tapsPerSec)
        
        radialGradient.intensify(k: 1.0 + tapsPerSec * 2 / 100)
        if runCounter > 15.0 && tapsPerSec > 15.0 {
            coeffitient = 5 * purshasedCoeffitient
        }
        else if runCounter > 10.0 && tapsPerSec > 10.0 {
            coeffitient = 3 * purshasedCoeffitient
        }
        else if runCounter > 5.0 && tapsPerSec > 5.0 {
            coeffitient = 2 * purshasedCoeffitient
        }
        else {
            coeffitient = 1 * purshasedCoeffitient
        }
        
        multiplyer.text = "X\(coeffitient)"
    }
    

    @IBAction func menuPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "GameToMenu", sender: nil)
    }
    

    @objc func peopleCounter() {
        tapsPerSec = CGFloat(nullCounter)
        nullCounter = 0
    }
}
