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
    var general = [GeneralTable]()
    
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
    
    
    func getDataForCities() -> [AllWeatherData] {
        getFavoriteCities()
        
        var arrayOfWeatherData = [AllWeatherData]()
        
        let currentDay = Date()
        let fortatter = DateFormatter()
        fortatter.timeStyle = .short
        fortatter.dateStyle = .full
        
        let currentDateTime = fortatter.string(from: currentDay)
        
        if city.count > 0 {
            
            for i in 0...city.count-1 {
                let cityObject = city[i]
                
                let requstGeneralTable = GeneralTable.fetchRequest()
                let predicateCityID = NSPredicate(format: "cityID = %@", String(cityObject.id))
                let currentTime = Int32(Date().timeIntervalSince1970)
                let predicateCityTime = NSPredicate(format: "dt > %@", String(currentTime))
                let allPredicates = NSCompoundPredicate(type: .and, subpredicates: [predicateCityID, predicateCityTime])
                requstGeneralTable.predicate = allPredicates
                
                var generalWeatherData = (try? persistentContainer.viewContext.fetch(requstGeneralTable)) ?? []
                
                // сортируем даты от меньшего к большему
                generalWeatherData.sort { $0.dt < $1.dt }
                
                for i in 0...generalWeatherData.count-1 {
                    
                    let timeForPrediction = getTime(forValue: generalWeatherData[i].dt)
                    let DateForPrediction = getData(forValue: generalWeatherData[i].dt)
                    
                    let data = AllWeatherData(
                        cityID: generalWeatherData[i].cityID,
                        cityName: generalWeatherData[i].cityName!,
                        minMaxWeather: "\(String(Int(generalWeatherData[i].temp_min)))º / \(String(Int(generalWeatherData[i].temp_max)))º" ,
                        currentWeatherValue: String(Int(generalWeatherData[i].temp)) + "º",
                        descriptionWeather: String(generalWeatherData[i].descW ?? ""),
                        timeRise: getTime(forValue: cityObject.sunrise),
                        timeSunset: getTime(forValue: cityObject.sunset),
                        generalWeatherInfo: currentDateTime,
                        imageVisible: UIImage(systemName: "smoke")!,
                        valueVisible: String(Int(generalWeatherData[i].pop)) + "%",
                        imageRain: UIImage(systemName: "cloud.rain")!,
                        valueRain: "0%",
                        imageWind: UIImage(systemName: "wind")!,
                        valueWind: String(Int(generalWeatherData[i].speed)) + "м/с",
                        textTimeWeather: timeForPrediction,
                        imageCollectionView: UIImage(named: String(generalWeatherData[i].icon!))!,
                        textWeather: String(Int(generalWeatherData[i].temp)) + "º",
                        dataWeather: DateForPrediction,
                        imageWeather: UIImage(named: String(generalWeatherData[i].icon!))!,
                        vetPercent: String(Int(generalWeatherData[i].humidity)) + "%",
                        extraTextWeather: String(generalWeatherData[i].descW ?? ""),
                        degreesseData: "\(String(Int(generalWeatherData[i].temp_min)))º- \(String(Int(generalWeatherData[i].temp_max)))º")
                    
                    arrayOfWeatherData.append(data)
                }}}
        return arrayOfWeatherData
    }
    
    private func getTime(forValue: Int32) -> String {
        let timeForPrediction = Date(timeIntervalSince1970: TimeInterval(forValue))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: timeForPrediction)
    }
    
    private func getData(forValue: Int32) -> String{
        let DateForPrediction = Date(timeIntervalSince1970: TimeInterval(forValue))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: DateForPrediction)
    }
    
    // проверим наличие данных в таблицах
    func checkData(){
//        let requestForList = ListTable.fetchRequest()
//        let list = (try? persistentContainer.viewContext.fetch(requestForList))
//        self.list = list ?? []
//        
//        let requestForCloud = CloudsTable.fetchRequest()
//        let cloud = (try? persistentContainer.viewContext.fetch(requestForCloud))
//        self.cloud = cloud ?? []
//        
//        let requestForMain = MainTable.fetchRequest()
//        let main = (try? persistentContainer.viewContext.fetch(requestForMain))
//        self.main = main ?? []
//        
//        let requestForWeather = WeatherTable.fetchRequest()
//        let weather = (try? persistentContainer.viewContext.fetch(requestForWeather))
//        self.weather = weather ?? []
//        
//        let requestForWind = WindTable.fetchRequest()
//        let wind = (try? persistentContainer.viewContext.fetch(requestForWind))
//        self.wind = wind ?? []
//
//        let requestForCity = CityTable.fetchRequest()
//        let city = (try? persistentContainer.viewContext.fetch(requestForCity))
//        self.city = city ?? []
        
        let requestForGeneral = GeneralTable.fetchRequest()
        let general = (try? persistentContainer.viewContext.fetch(requestForGeneral))
        self.general = general ?? []
        
        saveContext()
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
        
        DispatchQueue.main.async {
            
            // нужно сохранить отдельно данные по городу
            self.persistentContainer.performBackgroundTask { contexBackgroundWeather in
                let weatherDataForCity = CityTable(context: contexBackgroundWeather)
                
                if CoreDataManager.shared.city.contains(where: { $0.name == weatherData.city.name }) {
                    print("Такой город уже есть, не добавляем")
                } else {
                    weatherDataForCity.id = weatherData.city.id
                    weatherDataForCity.name = weatherData.city.name
                    weatherDataForCity.country = weatherData.city.country
                    weatherDataForCity.sunrise = weatherData.city.sunrise
                    weatherDataForCity.sunset = weatherData.city.sunset
                    weatherDataForCity.lat = weatherData.city.coord.lat
                    weatherDataForCity.lon = weatherData.city.coord.lon
                    
                    try? contexBackgroundWeather.save()
                    DispatchQueue.main.async {
                      //  self.reloadData()
                        self.checkData()
                    }
                }
            }
            
            for i in 0...weatherData.list.count-1 {
                
                self.persistentContainer.performBackgroundTask { contexBackgroundWeather in
                    let weatherDataForAll = GeneralTable(context: contexBackgroundWeather)
                    weatherDataForAll.cityName = weatherData.city.name
                    weatherDataForAll.cityID = weatherData.city.id
                    weatherDataForAll.dt = Int32(weatherData.list[i].dt)
                    weatherDataForAll.pop = weatherData.list[i].pop
                    weatherDataForAll.dt_text = weatherData.list[i].dt_txt
                    
                    weatherDataForAll.temp = weatherData.list[i].main.temp
                    weatherDataForAll.feels_like = weatherData.list[i].main.feels_like
                    weatherDataForAll.temp_min = weatherData.list[i].main.temp_min
                    weatherDataForAll.temp_max = weatherData.list[i].main.temp_max
                    weatherDataForAll.pressure = weatherData.list[i].main.pressure
                    weatherDataForAll.humidity = weatherData.list[i].main.humidity
                    
                    weatherDataForAll.main = weatherData.list[i].weather[0].main
                    weatherDataForAll.descW = weatherData.list[i].weather[0].description
                    weatherDataForAll.icon = weatherData.list[i].weather[0].icon
                    
                    weatherDataForAll.all = Int16(weatherData.list[i].clouds.all)
                    
                    weatherDataForAll.speed = weatherData.list[i].wind.speed
                    weatherDataForAll.deg = Int16(weatherData.list[i].wind.deg)
                    
                    try? contexBackgroundWeather.save()
                    DispatchQueue.main.async {
                        //self.reloadData()
                        self.checkData()
                    }
                }}}
        
        // слушатель должен обновить данные
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKeyForNetUpdate), object: self)
    }
    
    func deleteAllData(general: [GeneralTable]){
            for i in 0...general.count-1 {
                persistentContainer.viewContext.delete(general[i])
                saveContext()
            }
        }
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                context.automaticallyMergesChangesFromParent = true
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
