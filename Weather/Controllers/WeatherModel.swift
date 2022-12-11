//
//  WeatherModel.swift
//  Weather
//
//  Created by Nikita Byzov on 07.12.2022.
//

import UIKit
import CoreLocation

public func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
   
   let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
   var tempValueString: String = ""
   if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
   
   let urlForCertainTown = APIData.urlHTTPS+"lat=\(lat)"+"&lon=\(lot)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
   
   NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
       if answer != nil {
           CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
       } else {
           print("нил вернулся вместо ответа")
       }
   }
}
