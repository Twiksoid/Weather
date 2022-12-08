//
//  Constants.swift
//  Weather
//
//  Created by Nikita Byzov on 27.11.2022.
//

import UIKit

enum APIData {
    static  let apiKey = "21e407b6a635ca68d252e0d177d3b9cf"
    static let urlHTTPS = "https://api.openweathermap.org/data/2.5/forecast?"
    static let cnt = 40
    static let lang = "ru"
    static  let urlAPI = "http://api.api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&cnt={40}&appid={API key}&units={Unit}&lang={ru}"
    
    static  let metric = "metric" // м и км и Сº
    static  let imperial = "imperial" // дюйм фунт и Fº
    
    static  let newURL = "https://api.openweathermap.org/data/2.5/forecast?lat=43.2585092&lon=76.9249928&cnt=40&appid=21e407b6a635ca68d252e0d177d3b9cf&units=metric&lang=ru"
    
}

enum Constants {
    static let nameOfSection = "Настройки"
    static let nameOfTemp = "Температура"
    static let nameOfSpeedW = "Скорость ветра"
    static let nameOfFormatTime = "Формат времени"
    static let nameOfMentions = "Уведомления"
    static let nameOfSetButton = "Установить"
    
    static let titleTextFieldAllow = "Разрешить приложению Weather использовать данные о местоположении вашего устройства"
    static let titleTextFieldCorrct = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
    static let titleTextFieldChange = "Вы можете изменить свой выбор в любое время из меню приложения"
    static let allowButtonText = "Использовать местоположение устройства"
    static let denyButtonText = "Нет, я буду добавлять локации"
    
    static let alarmTownName = "Для продолжения укажите город для поиска погоды"
    static let alarmTownText = "Укажите страну и город"
    static let alarmTownOk = "Добавить"
    static let alarmTownCansel = "Отменить"
    
}

let headerData: HeaderData = .init(minMaxWeather: "7º/13º",
                                   currentWeatherValue: "13º",
                                   descriptionWeather: "Возможен дождь",
                                   timeRise: "05:41",
                                   timeSunset: "19:37",
                                   generalWeatherInfo: "17:48, Fr 16 April",
                                   imageVisible: UIImage(named: "03d")!,
                                   valueVisible: "0",
                                   imageRain: UIImage(named: "50d")!,
                                   valueRain: "75%",
                                   imageWind: UIImage(named: "01d")!,
                                   valueWind: "3 m/c")
let miniData: MiniData = .init(textTimeWeather: "12:00",
                               imageCollectionView: UIImage(named: "13d")!,
                               textWeather: "13º")

let textData: TextData = .init(dataWeather: "17/04",
                               imageWeather: UIImage(named: "04d")!,
                               vetPercent: "57%",
                               descriptionWeather: "Преимущественно облачно",
                               degreesseData: "4º-11º")

let allWeatherData1: AllWeatherData = .init(minMaxWeather: "7º/13º",
                                            currentWeatherValue: "13º",
                                            descriptionWeather: "Возможен дождь",
                                            timeRise: "05:41",
                                            timeSunset: "19:37",
                                            generalWeatherInfo: "17:48, Fr 16 April",
                                            imageVisible: UIImage(named: "03d")!,
                                            valueVisible: "0",
                                            imageRain: UIImage(named: "50d")!,
                                            valueRain: "75%",
                                            imageWind: UIImage(named: "01d")!,
                                            valueWind: "3 m/c",
                                            textTimeWeather: "12:00",
                                            imageCollectionView: UIImage(named: "13d")!,
                                            textWeather: "13º",
                                            dataWeather: "17/04",
                                            imageWeather: UIImage(named: "04d")!,
                                            vetPercent: "57%",
                                            extraTextWeather: "Преимущественно облачно",
                                            degreesseData: "4º-11º")

let allWeatherData2: AllWeatherData = .init(minMaxWeather: "1º/3º",
                                            currentWeatherValue: "3º",
                                            descriptionWeather: "Возможен снег",
                                            timeRise: "05:49",
                                            timeSunset: "18:37",
                                            generalWeatherInfo: "17:48, St 16 April",
                                            imageVisible: UIImage(named: "03d")!,
                                            valueVisible: "0",
                                            imageRain: UIImage(named: "50d")!,
                                            valueRain: "85%",
                                            imageWind: UIImage(named: "01d")!,
                                            valueWind: "1 m/c",
                                            textTimeWeather: "12:00",
                                            imageCollectionView: UIImage(named: "13d")!,
                                            textWeather: "3º",
                                            dataWeather: "17/04",
                                            imageWeather: UIImage(named: "04d")!,
                                            vetPercent: "57%",
                                            extraTextWeather: "Преимущественно снежно",
                                            degreesseData: "4º-11º")

extension UIColor {
    static let specialGreyForText = UIColor(red: 137 / 255, green: 131 / 255, blue: 131 / 255, alpha: 1)
    static let specialOrangeButton = UIColor(red: 242 / 255, green: 110 / 255, blue: 17 / 255, alpha: 1)
    static let specialBackgroundSettingsWhite = UIColor(red: 233 / 255, green: 238 / 255, blue: 250 / 255, alpha: 1)
    static let specialBackGroundBlue = UIColor(red: 32 / 255, green: 78 / 255, blue: 199 / 255, alpha: 1)
    static let specialBlue = UIColor(red: 31 / 255, green: 77 / 255, blue: 191 / 255, alpha: 1)
    static let specialGrey = UIColor(red: 254 / 255, green: 237 / 255, blue: 233 / 255, alpha: 1)
    static let specialGold = UIColor(red: 246 / 255, green: 221 / 255, blue: 1 / 255, alpha: 1)
}

extension Double {
    func makeFourSign(value: Double) -> Double {
        return (1000 * value ).rounded() / 1000
    }
}

extension UIImage {
    func getImageByCode(code: String) -> UIImage {
        switch code {
        case "01d":
            return UIImage(named: "01d.png")!
        case "01n":
            return UIImage(named: "01n.png")!
        case "02d":
            return UIImage(named: "02d.png")!
        case "02n":
            return UIImage(named: "02n.png")!
        case "03d":
            return UIImage(named: "03d.png")!
        case "03n":
            return UIImage(named: "03n.png")!
        case "04d":
            return UIImage(named: "04d.png")!
        case "04n":
            return UIImage(named: "04n.png")!
        case "09d":
            return UIImage(named: "09d.png")!
        case "09n":
            return UIImage(named: "09n.png")!
        case "10d":
            return UIImage(named: "10d.png")!
        case "10n":
            return UIImage(named: "10n.png")!
        case "11d":
            return UIImage(named: "11d.png")!
        case "11n":
            return UIImage(named: "11n.png")!
        case "13d":
            return UIImage(named: "13d.png")!
        case "13n":
            return UIImage(named: "13n.png")!
        case "50d":
            return UIImage(named: "50d.png")!
        case "50n":
            return UIImage(named: "50n.png")!
        default:
            return UIImage(systemName: "ladybug")!
        }
    }
}
