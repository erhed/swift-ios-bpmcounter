//
//  ViewController.swift
//  BPM Counter
//
//  Created by Erik on 2018-09-03.
//  Copyright © 2018 Erik. All rights reserved.
//

import UIKit

extension UIButton {
    func addTextSpacing(_ letterSpacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: letterSpacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var bpmText: UILabel!
    @IBOutlet weak var previousBPM: UILabel!
    @IBOutlet weak var tapTempoButtonOutlet: UIButton!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var firstClickAnimate: UILabel!

    var prevTime: Int = 0
    var countClicks: Int = 0
    var currentTime: Int = 0
    var bpm: Double = 0
    var timeDifference: Int = 0
    var bpmTotal: Double = 0
    var bpmResult: Double = 0
    var previousResult: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapTempoButtonOutlet.addTextSpacing(3.0)
        resetButtonOutlet.addTextSpacing(3.0)
    }
    
    @IBAction func tapTempoButton(_ sender: Any) {
        tempoTap()
    }
    
    @IBAction func resetButton(_ sender: Any) {
        reset()
    }
    
    func getTime() -> Int {
        let date = Date()
        let timeInterval = date.timeIntervalSince1970 * 1000
        let dateInt = Int(timeInterval)
        return dateInt
    }
    
    func tempoTap() {
        if (prevTime == 0) {
            prevTime = getTime()
            animateFirstClick()
        } else if ((getTime()-prevTime) > 2200) {
            animateFirstClick()
            reset()
        } else {
            currentTime = getTime()
            timeDifference = currentTime - prevTime
            prevTime = currentTime
            bpm = 60 / Double(timeDifference)
            bpmTotal = bpmTotal + bpm
            countClicks += 1
            bpmResult = (bpmTotal / Double(countClicks)) * 1000
            bpmText.text = String(format:"%.0f", bpmResult)
            previousResult = bpmResult
        }
    }
    
    func reset() {
        if (bpmResult != 0) {
            previousBPM.text = String(format:"%.0f", bpmResult)
        }
        prevTime = 0
        bpm = 0
        bpmTotal = 0
        bpmResult = 0
        countClicks = 0
        bpmText.text = "-"
    }
    
    func animateFirstClick() {
        UIView.animate(withDuration: 0.1) {
            self.bpmText.alpha = 0.0
        }
        UIView.animate(withDuration: 0.1) {
            self.bpmText.alpha = 1.0
        }
    }
}
