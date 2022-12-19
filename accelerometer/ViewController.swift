//
//  ViewController.swift
//  accelerometer
//
//  Created by Елизавета Хворост on 19/12/2022.
//

import UIKit
import CoreMotion

extension CGRect
{
    func hasIntersectionWith(_ rects: [CGRect]) -> Bool
    {
        for eachFrame in rects
        {
            if self.intersects(eachFrame)
            {
                return true
            }
        }
        return false
    }
}

class ViewController: UIViewController
{
    let motionManager = CMMotionManager()

    let diameter: CGFloat = 50
    let offset: CGFloat = UIScreen.main.bounds.height * 0.1
    let myCircle = UIView()
    
    var timer: Timer!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        motionManager.startAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0 / 60.0,
                                     target: self,
                                     selector: #selector(ViewController.update),
                                     userInfo: nil,
                                     repeats: true)
        
        self.myCircle.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.diameter,
                                     height: self.diameter)
        self.myCircle.backgroundColor = .orange
        self.myCircle.layer.cornerRadius = self.diameter * 0.5
        self.view.addSubview(self.myCircle)
        self.myCircle.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
    }
    
    @objc func update()
    {
        if let accelerometerData = motionManager.accelerometerData
        {
            let x = accelerometerData.acceleration.x
            let y = accelerometerData.acceleration.y
            let currentCenter = self.myCircle.center
            let newCenter = CGPoint(x: currentCenter.x + x * 5, y: currentCenter.y - y * 5)
            let radius = self.diameter * 0.5
            if newCenter.x - radius > 0 && newCenter.x + radius < UIScreen.main.bounds.width && newCenter.y - radius > 0 && newCenter.y + radius < UIScreen.main.bounds.height
            {
                self.myCircle.center = newCenter
            }
        }
    }
}


