//
//  NetworkManager.swift
//  Weather
//
//  Created by Nikita Byzov on 29.11.2022.
//

import UIKit

// Шапка ответа
struct Answer: Decodable {
    var cnt: Int // солько записей вернулось с шагом в 3 часа
    var list: [List]
    var city: City
}

struct City: Decodable {
    var id: Int32
    var name: String
    var country: String
    var sunrise: Int32
    var sunset: Int32
}

// Вложения Листа
struct List: Decodable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var pop: Double //fall
    var dt_txt: String
}

// Вложения основных данных
struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double // wet
}
// данные по погоде общие
struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
// данные по облачности
struct Clouds: Decodable {
    var all: Int
}
// данные по ветренности
struct Wind: Decodable {
    var speed: Double
    var deg: Int // direction
}

struct NetworkManager {
    
    func downloadData(urlString: String, comletionHandler: ((_ answer: Answer?) -> Void)? ) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if statusCode != 200 && statusCode != 409 {
                    print(String(describing: error))
                } else if statusCode == 409 {
                    // тут лимит выполнен
                }
                
                if data == nil {
                    print(String(describing: error))
                    fatalError("Либо не скачали, либо нет инета")
                }
                
                do {
                    let answer = try JSONDecoder().decode(Answer.self, from: data!)
                    comletionHandler?(answer)
                    
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
            }
            task.resume()
        } else {
            print("URL is nil!")
        }
    }
}
