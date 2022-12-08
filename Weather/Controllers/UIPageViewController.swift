//
//  UIPageViewController.swift
//  Weather
//
//  Created by Nikita Byzov on 29.11.2022.
//

import UIKit
import CoreData

class PageViewController: UIPageViewController {
    
    var arrayOfWeatherData = [AllWeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
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
        for vc in arrayOfWeatherData {
            weatherVCs.append(WeatherDataController(allweatherData: vc))
        }
        return weatherVCs
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        arrayOfWeatherData.append(allWeatherData1)
        arrayOfWeatherData.append(allWeatherData2)
        print(arrayOfWVC.count, arrayOfWeatherData.count)
        setViewControllers([arrayOfWVC[0]], direction: .forward, animated: true)
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
