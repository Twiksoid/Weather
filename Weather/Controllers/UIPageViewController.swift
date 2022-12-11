//
//  UIPageViewController.swift
//  Weather
//
//  Created by Nikita Byzov on 29.11.2022.
//

import UIKit
import CoreData
import CoreLocation

class PageViewController: UIPageViewController {

    var addressOfCity: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    var arrayOfWeatherData = [AllWeatherData]()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    func getDataForCities(){
    // После этого нужно загрузить новые данные для этих городов
    let cities = CoreDataManager.shared.city
    if cities.count > 0 {
        for i in 0...cities.count-1 {
            print("текущий город - ",cities[i].name!)
            LocationManager.shared.forwardGeocoding(address: cities[i].name!) { [self] coordinates in
                print("Объект в результате декодинга Имени города - ", coordinates)
                self.latitude = coordinates.latitude
                self.longitude = coordinates.longitude
                if (self.latitude != nil) && (self.longitude != nil) {
                    getDataLocationFor(lat: self.latitude!, lot: self.longitude!)
                } else {
                print("город не распознали, данные не загрузили")}
            }}
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataForCities()
        // нужно сходить в сеть
        // для каждого города в таблице
        // загрузить данные
        // положить данные в виде объекта в массив
        // вызвать пейжвьюконтроллер
        setupView()
        setVCForPage()
        }
     private func setVCForPage(){
          arrayOfWeatherData.append(allWeatherData1)
  //        arrayOfWeatherData.append(allWeatherData2)
              setViewControllers([arrayOfWVC[0]], direction: .forward, animated: true)
    }
    
    private func setupView(){
        setupNavigationBar()
        view.backgroundColor = .white
        delegate = self
        dataSource = self
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.direction = .natural
        pageControl.backgroundStyle = .prominent
    }
    
    lazy var arrayOfWVC: [WeatherDataController] = {
        var weatherVCs = [WeatherDataController]()
        if CoreDataManager.shared.city.count == 0 {
            weatherVCs.append(WeatherDataController(isInit: true))
        } else {
            for vc in arrayOfWeatherData {
                CoreDataManager.shared.getDataForCities()
                weatherVCs.append(WeatherDataController(allweatherData: vc))
            }}
            return weatherVCs
        }()
    
    private func setupNavigationBar(){
          navigationItem.title = "Test weather data"
          navigationController?.navigationBar.backgroundColor = .systemBackground
          navigationController?.navigationBar.prefersLargeTitles = false
          
        // создаю новый объект в верхнем баре
        let settings = UIBarButtonItem(image: UIImage(systemName: "server.rack"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(settingsTapped))
        let newTown = UIBarButtonItem(image: UIImage(systemName: "location.magnifyingglass"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(newTownTapped))
          
          // добавляю его в доступные к выводу справа и слева
          navigationItem.rightBarButtonItems = [newTown]
          navigationItem.leftBarButtonItems = [settings]
      }
    
    @objc private func settingsTapped() {
        navigationController?.pushViewController(SettingsController(), animated: true)
    }
    @objc private func newTownTapped() {
        // тут нужно уже не локацию спрашивать, а алерт показывать
        // чтобы из этого алерта захватить город и передать его в модель
        TextPicker.defaultPicker.getText(in: self) { text in
            self.addressOfCity = text
            if self.addressOfCity != "" || self.addressOfCity != nil {
                LocationManager.shared.forwardGeocoding(address: self.addressOfCity!) { data in
                    self.latitude = data.latitude
                    self.longitude = data.longitude
                    
                    print(self.addressOfCity!)
                    print(self.latitude!)
                    print(self.longitude!)
                    
                    self.getDataLocationFor(lat: self.latitude!, lot: self.longitude!)
                } } else {
                    print("nil field")
                }
        }
    }
    
    private func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
        
        let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
        var tempValueString: String = ""
        if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
        
        let urlForCertainTown = APIData.urlHTTPS+"lat=\(self.latitude!)"+"&lon=\(self.longitude!)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
        
        NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
            if answer != nil {
                CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
                
                DispatchQueue.main.async {
                    let wDC = WeatherDataController()
                    wDC.pageMainSceneDelegate = self
                    print(self.arrayOfWeatherData, self.arrayOfWVC)
                    wDC.viewDidLoad()
//                    self.imagePlusButton.isHidden = true
                }
                
            } else {
                print("нил вернулся вместо ответа")
            }
        }
    }
    
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let vc  = viewController as? WeatherDataController {
            if let indexOfVC = arrayOfWVC.firstIndex(of: vc) {
                if indexOfVC > 0 { return arrayOfWVC[indexOfVC - 1] }
            }} else { return nil}
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc  = viewController as? WeatherDataController {
            if let indexOfVC = arrayOfWVC.firstIndex(of: vc) {
                if indexOfVC < arrayOfWeatherData.count - 1 { return arrayOfWVC[indexOfVC + 1] }
            }} else { return nil}
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        arrayOfWeatherData.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}
