//
//  CoreDataManager.swift
//  Weather
//
//  Created by Nikita Byzov on 28.11.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init(){
        reloadData()
    }
    
    var settings = [Settings]()
    var list = [ListTable]()
    var cloud = [CloudsTable]()
    var main = [MainTable]()
    var weather = [WeatherTable]()
    var wind = [WindTable]()
    var city = [CityTable]()
    //var data: [AllWeatherData?]
    
    func checkSettings(){
        let request = Settings.fetchRequest()
        let setting = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.settings = setting
    }
    
    func reloadData(){
        checkSettings()
    }
    
    func getFavoriteCities(){
        let request = CityTable.fetchRequest()
        let cities = (try? persistentContainer.viewContext.fetch(request))
        self.city = cities ?? []
    }
    
    func getDataForCities(){
        getFavoriteCities()
        
        if city.count > 0 {
            for i in 0...city.count-1 {
                let cityID = city[i].id
                
                let request = ListTable.fetchRequest()
                let predicateCityID = NSPredicate(format: "cityID = %@", String(cityID))
                let currentTime = Int32(Date().timeIntervalSince1970)
                let predicateCityTime = NSPredicate(format: "dt > %@", String(currentTime))
                let allPredicates = NSCompoundPredicate(type: .and, subpredicates: [predicateCityID, predicateCityTime])
                  request.predicate = allPredicates
                
                let list = (try? persistentContainer.viewContext.fetch(request)) ?? []
                print("Количество записей в листе - ", list.count)
                print(currentTime)
                
            }}}
    
    // проверим наличие данных в таблицах
    func checkData(){
        let requestForList = ListTable.fetchRequest()
        let list = (try? persistentContainer.viewContext.fetch(requestForList))
        self.list = list ?? []
        
        let requestForCloud = CloudsTable.fetchRequest()
        let cloud = (try? persistentContainer.viewContext.fetch(requestForCloud))
        self.cloud = cloud ?? []
        
        let requestForMain = MainTable.fetchRequest()
        let main = (try? persistentContainer.viewContext.fetch(requestForMain))
        self.main = main ?? []
        
        let requestForWeather = WeatherTable.fetchRequest()
        let weather = (try? persistentContainer.viewContext.fetch(requestForWeather))
        self.weather = weather ?? []
        
        let requestForWind = WindTable.fetchRequest()
        let wind = (try? persistentContainer.viewContext.fetch(requestForWind))
        self.wind = wind ?? []
        
        let requestForCity = CityTable.fetchRequest()
        let city = (try? persistentContainer.viewContext.fetch(requestForCity))
        self.city = city ?? []
    }
    
    func createSettings(temp: Int16, speed: Int16, hours: Int16, notifications: Int16){
        persistentContainer.performBackgroundTask({ contexBackground in
            let initialSettings = Settings(context: contexBackground)
            initialSettings.temp = temp
            initialSettings.speed = speed
            initialSettings.hours = hours
            initialSettings.notification = notifications
            
            try? contexBackground.save()
            DispatchQueue.main.async {
                self.reloadData()
            }
        })
    }
    
    func setNewSettingsValue(deleteCurrentSettings: Settings, temp: Int16, speed: Int16, hours: Int16, notifications: Int16){
        deleteAllSettings(settings: deleteCurrentSettings)
        createSettings(temp: temp, speed: speed, hours: hours, notifications: notifications)
    }
    
    func deleteAllSettings(settings: Settings){
        persistentContainer.viewContext.delete(settings)
        saveContext()
        reloadData()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    func saveNewWeatherDatas(weatherData: Answer){
        // пишут, что в weather может быть несколько условий погоды
        // но добиться такого примера не получилось пока
        // если воспроизведется, то нужна такая конструкция проверки
        // а пока можно всегда 0 брать
        // вроде, упасть не должно критично
        //        for i in 0...weatherData.list.count {
        //            if weatherData.list[i].weather.count > 1 {
        //        } else {}
        
        //        // сохраним отдельно количество пришедших записей
        //        persistentContainer.performBackgroundTask { contexBackgroundWeather in
        //            let weatherDataForGeneral = GeneralTable(context: contexBackgroundWeather)
        //            weatherDataForGeneral.cnt = Int16(weatherData.cnt)
        ////            weatherDataForGeneral.listID = UUID().uuidString
        //            try? contexBackgroundWeather.save()
        //            DispatchQueue.main.async {
        //                self.reloadData()
        //            }
        //        }
        
        // нужно сохранить отдельно данные по городу
        persistentContainer.performBackgroundTask { contexBackgroundWeather in
            let weatherDataForCity = CityTable(context: contexBackgroundWeather)
            
            if CoreDataManager.shared.city.contains(where: { $0.name == weatherData.city.name }) {
                print("Такой город уже есть, не добавляем")
            } else {
                weatherDataForCity.id = weatherData.city.id
                weatherDataForCity.name = weatherData.city.name
                weatherDataForCity.country = weatherData.city.country
                weatherDataForCity.sunrise = weatherData.city.sunrise
                weatherDataForCity.sunset = weatherData.city.sunset
                
                try? contexBackgroundWeather.save()
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
        
        
        for i in 0...weatherData.list.count-1 {
            
            persistentContainer.performBackgroundTask { contexBackgroundWeather in
                
                //                let weatherDataForGeneral = GeneralTable(context: contexBackgroundWeather)
                ////                weatherDataForGeneral.cnt = Int16(weatherData.cnt)
                ////                weatherDataForGeneral.listID = UUID().uuidString
                
                let weatherDataForList = ListTable(context: contexBackgroundWeather)
                // weatherDataForList.listID = weatherDataForGeneral.listID
                weatherDataForList.mainID = UUID().uuidString
                weatherDataForList.weatherID = UUID().uuidString
                weatherDataForList.cloudsID = UUID().uuidString
                weatherDataForList.windID = UUID().uuidString
                weatherDataForList.dt = Int32(weatherData.list[i].dt)
                weatherDataForList.pop = weatherData.list[i].pop
                weatherDataForList.dt_txt = weatherData.list[i].dt_txt
                weatherDataForList.cityID = weatherData.city.id
                
                let weatherDataForMain = MainTable(context: contexBackgroundWeather)
                weatherDataForMain.mainID = weatherDataForList.mainID
                weatherDataForMain.temp = weatherData.list[i].main.temp
                weatherDataForMain.feels_like = weatherData.list[i].main.feels_like
                weatherDataForMain.temp_min = weatherData.list[i].main.temp_min
                weatherDataForMain.temp_max = weatherData.list[i].main.temp_max
                weatherDataForMain.pressure = weatherData.list[i].main.pressure
                weatherDataForMain.humidity = weatherData.list[i].main.humidity
                
                let weatherDataForWeather = WeatherTable(context: contexBackgroundWeather)
                weatherDataForWeather.weatherID = weatherDataForList.weatherID
                weatherDataForWeather.idOfCondition = Int16(weatherData.list[i].weather[0].id)
                weatherDataForWeather.main = weatherData.list[i].weather[0].main
                weatherDataForWeather.des = weatherData.list[i].weather[0].description
                weatherDataForWeather.icon = weatherData.list[i].weather[0].icon
                
                let weatherDataForClouds = CloudsTable(context: contexBackgroundWeather)
                weatherDataForClouds.cloudsID = weatherDataForList.cloudsID
                weatherDataForClouds.all = Int16(weatherData.list[i].clouds.all)
                
                let weatherDataForWind = WindTable(context: contexBackgroundWeather)
                weatherDataForWind.windID = weatherDataForList.windID
                weatherDataForWind.speed = weatherData.list[i].wind.speed
                weatherDataForWind.deg = Int16(weatherData.list[i].wind.deg)
                
                try? contexBackgroundWeather.save()
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
    
    func deleteAllData(list: [ListTable], weather: [WeatherTable], main: [MainTable], wind: [WindTable], cloud: [CloudsTable]){
        for i in 0...list.count-1 {
            persistentContainer.viewContext.delete(list[i])
            saveContext()
        }
        
        for i in 0...weather.count-1 {
            persistentContainer.viewContext.delete(weather[i])
            saveContext()
        }
        
        for i in 0...main.count-1 {
            persistentContainer.viewContext.delete(main[i])
            saveContext()
        }
        
        for i in 0...wind.count-1 {
            persistentContainer.viewContext.delete(wind[i])
            saveContext()
        }
        
        for i in 0...cloud.count-1 {
            persistentContainer.viewContext.delete(cloud[i])
            saveContext()
        }
    }
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
