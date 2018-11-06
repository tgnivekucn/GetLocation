//
//  ViewController.swift
//  GetLocation
//
//  Created by 粘光裕 on 2018/11/5.
//  Copyright © 2018年 com.open.lib. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self //每次設定CLLocationManager的delegate,都會執行到didChangeAuthorization這個system callback
    }

    
    @IBAction func requestAuthorization(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var statusString = ""
        switch status {
        case .authorizedAlways:
            statusString = "authorizedAlways"
            break
        case .authorizedWhenInUse:
            statusString = "authorizedWhenInUse"
            break
        case .denied:
            statusString = "denied"
            break
        case .notDetermined:
            statusString = "notDetermined"
            break
        case .restricted:
            statusString = "restricted"
            break
        }
        if status == .denied || status == .restricted {
            showCustomAlert()
        }
        print("didChangeAuthorization  status is: \(statusString)")
    }
    
    func showCustomAlert() {
        let alert = UIAlertController(title: "", message: "要求定位權限", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "前往設定頁面", style: .default) {
            _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)

            })
        self.present(alert, animated: true, completion: nil)
    }
}
