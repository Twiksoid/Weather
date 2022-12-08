//
//  ViewController.swift
//  Weather
//
//  Created by Nikita Byzov on 27.11.2022.
//

import UIKit
import CoreLocation
//import CoreData

class PermissionLocationController: UIViewController {
    
    //  var locationManager: CLLocationManager?
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    private lazy var imageGirl: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Girl.jpg")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleTextFieldAllow: UILabel = {
        let titleField = UILabel()
        titleField.numberOfLines = 0
        titleField.textAlignment = .center
        titleField.textColor = .white
        titleField.font = .boldSystemFont(ofSize: 20)
        titleField.text = Constants.titleTextFieldAllow
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var titleTextFieldCorrect: UILabel = {
        let titleField = UILabel()
        titleField.numberOfLines = 0
        titleField.textAlignment = .center
        titleField.textColor = .white
        titleField.font = .boldSystemFont(ofSize: 15)
        titleField.text = Constants.titleTextFieldCorrct
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var titleTextFieldChange: UILabel = {
        let titleField = UILabel()
        titleField.numberOfLines = 0
        titleField.textAlignment = .center
        titleField.textColor = .white
        titleField.font = .boldSystemFont(ofSize: 15)
        titleField.text = Constants.titleTextFieldChange
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    //MARK: Button
    
    private lazy var allowButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.allowButtonText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.backgroundColor = UIColor.specialOrangeButton
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(allowGot), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc private func allowGot(){
        // спрашиваем разрешение на геолокацию
        // вне зависимости от ответа переходим вперед и выдаем стандартное окно запроса
        getLocationsAllow()
        firstLoginWas()
    }
    
    private lazy var denyButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.denyButtonText, for: .normal)
        button.backgroundColor = UIColor.specialOrangeButton
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(denyGot), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc private func denyGot(){
        // тут мы отказываемся, поэтому сразу вперед
        firstLoginWas()
    }
    
    private func firstLoginWas(){
        UserDefaults.standard.set("firstLogin", forKey: "onboarding")
        performSegue(withIdentifier: "onboardToMain", sender: self)
        UserDefaults.standard.synchronize()
    }
    
    
    private func setupView(deviceType: String, beetween: CGFloat, lead: CGFloat, trailing: CGFloat,  imageWidSize: CGFloat? = nil, imageHeiSize: CGFloat? = nil){
        // поскольку слишком мало элементов для UI
        // а сделать надо под iPad
        // то придется махинации делать
        
        if deviceType == "iPad" {
            titleTextFieldAllow.font = .boldSystemFont(ofSize: 35)
            titleTextFieldChange.font = .boldSystemFont(ofSize: 28)
            titleTextFieldCorrect.font = .boldSystemFont(ofSize: 28)
        }
        
        if deviceType == "iPhone" {
            NSLayoutConstraint.activate([
                imageGirl.heightAnchor.constraint(equalToConstant: imageHeiSize!),
                imageGirl.widthAnchor.constraint(equalToConstant: imageWidSize!)
            ])
        }
        
        view.backgroundColor = UIColor.specialBackGroundBlue
        
        view.addSubview(imageGirl)
        view.addSubview(titleTextFieldAllow)
        view.addSubview(titleTextFieldChange)
        view.addSubview(titleTextFieldCorrect)
        view.addSubview(allowButton)
        view.addSubview(denyButton)
        
        NSLayoutConstraint.activate([
            imageGirl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageGirl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleTextFieldAllow.topAnchor.constraint(equalTo: imageGirl.bottomAnchor),
            titleTextFieldAllow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lead),
            titleTextFieldAllow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            
            titleTextFieldChange.topAnchor.constraint(equalTo: titleTextFieldAllow.bottomAnchor, constant: beetween),
            titleTextFieldChange.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lead),
            titleTextFieldChange.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            
            titleTextFieldCorrect.topAnchor.constraint(equalTo: titleTextFieldChange.bottomAnchor, constant: beetween),
            titleTextFieldCorrect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lead),
            titleTextFieldCorrect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            
            allowButton.topAnchor.constraint(equalTo: titleTextFieldCorrect.bottomAnchor, constant: beetween),
            allowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lead),
            allowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing),
            
            denyButton.topAnchor.constraint(equalTo: allowButton.bottomAnchor, constant: beetween),
            denyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lead),
            denyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
            
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.model == "iPhone" {
            setupView(deviceType: "iPhone", beetween: 30, lead: 10, trailing: -10, imageWidSize: 350, imageHeiSize: 280)
        }
        else if UIDevice.current.model == "iPad" {
            setupView(deviceType: "iPad", beetween: 60, lead: 25, trailing: -25)
        }
    }
    
    private func getLocationsAllow(){
        LocationManager.shared.getUserLocation { location in
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            
            let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
            var tempValueString: String = ""
            if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
            
            let urlForCertainTown = APIData.urlHTTPS+"lat=\(self.latitude!)"+"&lon=\(self.longitude!)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
            
            NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
                if answer != nil {
                    CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
                } else {
                    print("нил вернулся вместо ответа")
                }
            }
        }
    }
}
