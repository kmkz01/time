//
//  ViewController.swift
//  timer
//
//  Created by nishimoto_noboru on 2018/04/20.
//  Copyright © 2018年 nishimoto_noboru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var timer: Timer!
    var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startstopTimer(_ sender: Any) {
        switch(sender as AnyObject).selectedSegmentIndex {
        case 0:
            timer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(self.timerCounter),
                userInfo: nil,
                repeats: true)
            
            startTime = Date()
            break
        case 1:
            if timer != nil{
                timer.invalidate()
            }
            break
        default :
            //リセットボタン
            hrSegment.selectedSegmentIndex = 0
            spo2Segment.selectedSegmentIndex = 0
            displayTypeSegment.selectedSegmentIndex = 0
            cryingTypeSegment.selectedSegmentIndex = 0
            
            babyStatus.hr = 0
            babyStatus.spo2 = 0
            babyStatus.displayType = 0
            babyStatus.cryingType = 0
            
            //タイマーリセット
            if timer != nil{
                timer.invalidate()
                
                timerMinute.text = "00"
                timerSecond.text = "00"
                timerMSec.text = "00"
            }else{
                timerMinute.text = "00"
                timerSecond.text = "00"
                timerMSec.text = "00"
            }
            
            self.postState()
            
            break
        }
    }
    @objc func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        
        // fmod() 余りを計算
        let minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        let second = (Int)(fmod(currentTime, 60))
        // floor 切り捨て、小数点以下を取り出して *100
        let msec = (Int)((currentTime - floor(currentTime))*100)
        
        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        let sMsec = String(format:"%02d", msec)
        
        timerMinute.text = sMinute
        timerSecond.text = sSecond
        timerMSec.text = sMsec
    }

}

