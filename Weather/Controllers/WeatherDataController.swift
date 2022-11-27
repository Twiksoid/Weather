//
//  WeatherDataController.swift
//  Weather
//
//  Created by Nikita Byzov on 27.11.2022.
//

import UIKit

class WeatherDataController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func permissionLocationButtonTapped(_ sender: Any) {
        print("Tapped location")
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        print("Tapped settings")
        navigationController?.pushViewController(SettingsController(), animated: true)
    }
}
