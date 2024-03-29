//
//  IntroVC.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit
import RealmSwift

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
    @IBOutlet weak var menuBtn: UIButton!
    
    let realm = RealmService.instance.realm
    let radialGradient = RadialGradientView()
    
    // MARK: - Stats
    var gameStarted = false
    var runCounter: CGFloat = 0.0
    var tapsPerSec: CGFloat = 0.0
    var coeffitient = 1
    var nullCounter = 0
    var purshasedCoeffitient = 1
    
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
    
    // MARK: - DataService
    var virus = DataService.viruses[DataService.currentItemID]
    var user: User!
    var results: Results<User>!
    
    // MARK: - Score
    var counter: Int = 0
    var goal: Int = 100
    
    override func viewDidLoad() {
        loadProgress()
        addDefaultVirus()
        setupUI()
        observeTaps()
        updateVirusSettings()
        updateRadialGradient()
        observeRealmErrors()
        observeNotifications()
        super.viewDidLoad()
    }
    
    // MARK: - Realm Data Processing
    func updateUser(counter: Int, goal: Int) {
        let update: [String: Any?] = [Base.score: counter,
                                      Base.goal: goal]
        RealmService.instance.update(user, with: update)
        loadProgress()
    }
    
    func loadProgress() {
        user = realm.objects(User.self).first
        DataService.user = user
        counter = user.score
        goal = user.goal
        DataService.currentItemID = user.virusIndex
    }
    
    func observeRealmErrors() {
        RealmService.instance.observeRealmErrors(in: self) { (error) in
            print(error)
        }
    }
    
    func observeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateVirusSettings),
                                               name: .updateVirus,
                                               object: nil)
    }
    
    @objc func updateVirusSettings() {
        virus = DataService.viruses[DataService.currentItemID]
        updateColorScheme()
        virusImage.image = virus.image
        purshasedCoeffitient = virus.contaigousness
    }
    
    // MARK: - Virus Taps
    func observeTaps() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onVirusTap))
        virusImage.isUserInteractionEnabled = true
        virusImage.addGestureRecognizer(gesture)
    }
    
    func addDefaultVirus() {
        if user.availableViruses.isEmpty {
            let defaultItem = RealmItem(id: 0, contaigousness: 1)
            RealmService.instance.add(item: defaultItem)
        }
    }
    
    func unlockVirus(goal: Int) -> (Bool, Item?) {
        guard let unlockedItem = DataService.items.first(where: { $0.goal == goal }) else { return (false, nil) }
        guard let id = DataService.items.firstIndex(where: { $0 === unlockedItem }) else { return (false, nil) }
        let realmItem = RealmItem(id: id, contaigousness: unlockedItem.contaigousness, damage: unlockedItem.damage, mutation: unlockedItem.mutation)
        RealmService.instance.add(item: realmItem)
        NotificationCenter.default.post(name: .itemPurchased, object: nil)
        return (true, unlockedItem)
    }
    
    @objc func onVirusTap() {
        if !gameStarted {
            gameStarted = true
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
            var title: String!, text: String!
            let unlockResult = unlockVirus(goal: goal).self
            if unlockResult.0 {
                let name = unlockResult.1!.title.replacingOccurrences(of: "\n", with: " ")
                title = "Amazing!"
                text = "New virus unlocked: \(name). Visit Customize to try it out"
            } else {
                title = "Fascinating!"
                text = "The virus is spreading rapidly! You have infected \(goal) people."
            }
            self.showUpperAlert(title: title,
                                text: text,
                                countdown: 3)
            goal *= 10
        }
        updateUser(counter: counter, goal: goal)
        virusImage.scaleOutIn(duration: duration, delay: delay, scaleX: scaleX, scaleY: scaleY)
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
