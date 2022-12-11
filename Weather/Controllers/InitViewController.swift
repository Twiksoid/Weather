//
//  InitViewController.swift
//  Weather
//
//  Created by Nikita Byzov on 09.12.2022.
//

import UIKit
import CoreLocation

class InitViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in CoreDataManager.shared.city {
            getDataLocationFor(lat: i.lat, lot: i.lon)
        }}
    
    private func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
        let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
        var tempValueString: String = ""
        if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
        
        let urlForCertainTown = APIData.urlHTTPS+"lat=\(lat)"+"&lon=\(lot)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
        
        NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
            if answer != nil {
                CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
                DispatchQueue.main.async {
                    self.makeRootController()
                }
            } else {
                print("нил вернулся вместо ответа")
            }
        }
    }
    
    private func makeRootController(){
        var viewControllerForShowing: UIViewController
        viewControllerForShowing = PageViewController()
        
        if (UserDefaults.standard.value(forKey: "onboarding") as? String) == nil {
            viewControllerForShowing = PermissionLocationController()
            pushViewController(viewControllerForShowing, animated: true)
        } else {
            DispatchQueue.main.async {
                self.pushViewController(viewControllerForShowing, animated: true)
            }}
    }
}
