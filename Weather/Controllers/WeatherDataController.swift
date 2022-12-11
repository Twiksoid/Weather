//
//  WeatherDataController.swift
//  Weather
//
//  Created by Nikita Byzov on 27.11.2022.
//

import UIKit
import CoreLocation

class WeatherDataController: UIViewController {
    
    weak var pageMainSceneDelegate: PageViewController?
    
    func reloadData(){
        self.imagePlusButton.isHidden = true
    }
    
    var allWeatherData: AllWeatherData?
    //    var header: HeaderData?
    //    var mini: MiniData?
    //    var text: TextData?
    var addressOfCity: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var isInit: Bool?
    
    private lazy var imagePlusButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "imagePlus.png"), for: .normal)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        return image
    }()
    
    @objc private func imageTapped(){

        let alert = UIAlertController(title: "Внимание!",
                                      message: "Для добавления города, нажмите в правом верхнем углу",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Понятно",
                                     style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout )
        collection.dataSource = self
        collection.delegate = self
        collection.layer.cornerRadius = 10
        collection.clipsToBounds = true
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collection.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "HeaderCell")
        collection.register(MiniWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "MiniWeather")
        collection.register(TextWeatherDataCollectionViewCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    init(allweatherData: AllWeatherData? = nil,
         addressOfCity: String? = nil,
         latitude: CLLocationDegrees? = nil,
         longitude: CLLocationDegrees? = nil,
         isInit: Bool? = nil
         // , imagePlusButton: UIButton? = nil
         // , layout: UICollectionViewFlowLayout? = nil,
         // collectionView: UICollectionView? = nil) {
    ){
        super.init(nibName: nil, bundle: nil)
        self.addressOfCity = addressOfCity
        self.latitude = latitude
        self.longitude = longitude
        //   self.imagePlusButton = imagePlusButton
        //  self.layout = layout!
        //   self.collectionView = collectionView!
        self.allWeatherData = allweatherData
        //        self.header = weatherHeder
        //        self.mini = weatherMini
        //        self.text = weatherText
        self.isInit = isInit
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CoreDataManager.shared.city.count == 0 && isInit == true {
            collectionView.isHidden = true
            view.addSubview(imagePlusButton)
            
            NSLayoutConstraint.activate([
                imagePlusButton.heightAnchor.constraint(equalToConstant: 400),
                imagePlusButton.widthAnchor.constraint(equalToConstant: 400),
                imagePlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imagePlusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        } else {
          //  getDataForCurrentLocation()
        }
        
        setupView()
    }
    
    private func getDataForCurrentLocation(){
        LocationManager.shared.getUserLocation { location in
            
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            
            self.getDataLocationFor(lat: self.latitude!, lot: self.longitude!)
        }
    }
    
    private func setupView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//  private func setupNavigationBar(){
//        navigationItem.title = "Test weather data"
//        navigationController?.navigationBar.backgroundColor = .systemBackground
//        navigationController?.navigationBar.prefersLargeTitles = false
//
//        // создаю новый объект в верхнем баре
//        let settings = UIBarButtonItem(image: UIImage(systemName: "server.rack"),
//                                       style: .plain,
//                                       target: self,
//                                       action: #selector(settingsTapped))
//        let newTown = UIBarButtonItem(image: UIImage(systemName: "location.magnifyingglass"),
//                                      style: .plain,
//                                      target: self,
//                                      action: #selector(newTownTapped))
//
//        // добавляю его в доступные к выводу справа и слева
//        navigationItem.rightBarButtonItems = [newTown]
//        navigationItem.leftBarButtonItems = [settings]
//    }
//
//    @objc private func settingsTapped() {
//        navigationController?.pushViewController(SettingsController(), animated: true)
//    }
//    @objc private func newTownTapped() {
//        // тут нужно уже не локацию спрашивать, а алерт показывать
//        // чтобы из этого алерта захватить город и передать его в модель
//        TextPicker.defaultPicker.getText(in: self) { text in
//            self.addressOfCity = text
//            if self.addressOfCity != "" || self.addressOfCity != nil {
//                LocationManager.shared.forwardGeocoding(address: self.addressOfCity!) { data in
//                    self.latitude = data.latitude
//                    self.longitude = data.longitude
//
//                    print(self.addressOfCity!)
//                    print(self.latitude!)
//                    print(self.longitude!)
//
//                    self.getDataLocationFor(lat: self.latitude!, lot: self.longitude!)
//                } } else {
//                    print("nil field")
//                }
//        }
//    }
    
    private func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
        
        let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
        var tempValueString: String = ""
        if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
        
        let urlForCertainTown = APIData.urlHTTPS+"lat=\(self.latitude!)"+"&lon=\(self.longitude!)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
        
        NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
            if answer != nil {
                CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
                
                DispatchQueue.main.async {
                    self.imagePlusButton.isHidden = true
                    self.collectionView.isHidden = false
                }
                
            } else {
                print("нил вернулся вместо ответа")
            }
        }
    }
}

extension WeatherDataController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    // секция 1, шапка
    // секция 2, мини прогноз
    // секция 3, деталка
    // средние значения: для айфона 5 вместится, для айпада 11
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 1} else if section == 1 {return Int((collectionView.frame.width - 50 ) / 60)}  else { return 19 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCollectionViewCell {
                cell.setupCell(for: allWeatherData ?? allWeatherData1)
                return cell
            } else {let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return cell}
        } else if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniWeather", for: indexPath) as? MiniWeatherCollectionViewCell {
                cell.setupCell(for: allWeatherData ?? allWeatherData1)
                return cell
            } else {let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return cell}} else {
                    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as? TextWeatherDataCollectionViewCell {
                        cell.setupCell(for: allWeatherData ?? allWeatherData1)
                        return cell
                    } else {let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                        return cell}
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 250)
        } else if indexPath.section == 1 {
            return CGSize(width: 50, height: 70)
        } else {
            return CGSize(width: collectionView.frame.width-10, height: 80)
        }
    }
}

