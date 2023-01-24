//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes : [String: Float] = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var totalTime : Float = 0
    var secondsPassed : Float = 0
    
    var timer = Timer()
    
    var player : AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        titleLabel.text = "How do you like your eggs?"
        
        let hardness = sender.currentTitle!
        progressBar.progress = 0.0
        
        totalTime = eggTimes[hardness]!
        secondsPassed = 0.0
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(count: Int) {
        if secondsPassed < totalTime {
            secondsPassed += 1
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
        let percentageProgress : Float = secondsPassed / totalTime
        progressBar.progress = percentageProgress
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
