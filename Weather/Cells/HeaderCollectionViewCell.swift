//
//  HeaderCollectionViewCell.swift
//  Weather
//
//  Created by Nikita Byzov on 06.12.2022.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageLine: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        image.image = UIImage(named: "line.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var minMaxWeather: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var currentWeatherValue: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var descriptionWeather: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageRise: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.image = UIImage(systemName: "sunrise.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var timeRise: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageSunset: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.image = UIImage(systemName: "sunset.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var timeSunset: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var generalWeatherInfo: UILabel = {
        let text = UILabel()
        //text.textColor = .specialGold
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageVisible: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var valueVisible: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageRain: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var valueRain: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageWind: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var valueWind: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(imageLine)
        addSubview(minMaxWeather)
        addSubview(currentWeatherValue)
        addSubview(descriptionWeather)
        addSubview(imageRise)
        addSubview(timeRise)
        addSubview(imageSunset)
        addSubview(timeSunset)
        addSubview(generalWeatherInfo)
        addSubview(imageVisible)
        addSubview(valueVisible)
        addSubview(imageRain)
        addSubview(valueRain)
        addSubview(imageWind)
        addSubview(valueWind)
        
        NSLayoutConstraint.activate([
            
            imageLine.topAnchor.constraint(equalTo: topAnchor),
            imageLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            imageLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            imageLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            
            minMaxWeather.topAnchor.constraint(equalTo: imageLine.topAnchor, constant: 10),
            minMaxWeather.heightAnchor.constraint(equalToConstant: 20),
            minMaxWeather.centerXAnchor.constraint(equalTo: centerXAnchor),
            minMaxWeather.bottomAnchor.constraint(equalTo: currentWeatherValue.topAnchor, constant: -10),
            
            currentWeatherValue.topAnchor.constraint(equalTo: minMaxWeather.bottomAnchor, constant: 10),
            currentWeatherValue.heightAnchor.constraint(equalToConstant: 20),
            currentWeatherValue.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentWeatherValue.bottomAnchor.constraint(equalTo: descriptionWeather.topAnchor, constant: -20),
            
            descriptionWeather.topAnchor.constraint(equalTo: currentWeatherValue.bottomAnchor, constant: 10),
            descriptionWeather.heightAnchor.constraint(equalToConstant: 20),
            descriptionWeather.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionWeather.bottomAnchor.constraint(equalTo: generalWeatherInfo.topAnchor, constant: -70),
            
            imageRise.topAnchor.constraint(equalTo: imageLine.bottomAnchor, constant: 20),
            imageRise.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageRise.bottomAnchor.constraint(equalTo: timeRise.topAnchor),
            imageRise.heightAnchor.constraint(equalToConstant: 40),
            imageRise.widthAnchor.constraint(equalToConstant: 40),
            
            timeRise.topAnchor.constraint(equalTo: imageRise.bottomAnchor),
            timeRise.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timeRise.bottomAnchor.constraint(equalTo: bottomAnchor),
            timeRise.heightAnchor.constraint(equalToConstant: 20),
            timeRise.widthAnchor.constraint(equalToConstant: 50),
            
            imageSunset.topAnchor.constraint(equalTo: imageLine.bottomAnchor, constant: 20),
            imageSunset.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageSunset.bottomAnchor.constraint(equalTo: timeSunset.topAnchor),
            imageSunset.heightAnchor.constraint(equalToConstant: 40),
            imageSunset.widthAnchor.constraint(equalToConstant: 40),
            
            timeSunset.topAnchor.constraint(equalTo: imageSunset.bottomAnchor),
            timeSunset.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timeSunset.bottomAnchor.constraint(equalTo: bottomAnchor),
            timeSunset.heightAnchor.constraint(equalToConstant: 20),
            timeSunset.widthAnchor.constraint(equalToConstant: 50),
            
            generalWeatherInfo.topAnchor.constraint(equalTo: descriptionWeather.bottomAnchor, constant: 70),
            generalWeatherInfo.centerYAnchor.constraint(equalTo: descriptionWeather.centerYAnchor),
            generalWeatherInfo.leadingAnchor.constraint(equalTo: timeRise.leadingAnchor, constant: 50),
            generalWeatherInfo.trailingAnchor.constraint(equalTo: timeSunset.trailingAnchor, constant: -50),
            generalWeatherInfo.widthAnchor.constraint(equalToConstant: 20),
            generalWeatherInfo.heightAnchor.constraint(equalToConstant: 20),
            generalWeatherInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            imageWind.topAnchor.constraint(equalTo: descriptionWeather.bottomAnchor, constant: 15),
            imageWind.centerXAnchor.constraint(equalTo: descriptionWeather.centerXAnchor, constant: -20),
            imageWind.widthAnchor.constraint(equalToConstant: 40),
            imageWind.heightAnchor.constraint(equalToConstant: 40),
            
            valueWind.centerYAnchor.constraint(equalTo: imageWind.centerYAnchor),
            valueWind.leadingAnchor.constraint(equalTo: imageWind.trailingAnchor),
            valueWind.heightAnchor.constraint(equalToConstant: 20),
            valueWind.widthAnchor.constraint(equalToConstant: 50),
            
            imageVisible.topAnchor.constraint(equalTo: descriptionWeather.bottomAnchor, constant: 15),
            imageVisible.bottomAnchor.constraint(equalTo: generalWeatherInfo.topAnchor, constant: -15),
            imageVisible.centerYAnchor.constraint(equalTo: imageWind.centerYAnchor),
            imageVisible.heightAnchor.constraint(equalToConstant: 40),
            imageVisible.widthAnchor.constraint(equalToConstant: 40),
            
            valueVisible.centerYAnchor.constraint(equalTo: imageVisible.centerYAnchor),
            valueVisible.leadingAnchor.constraint(equalTo: imageVisible.trailingAnchor),
            valueVisible.trailingAnchor.constraint(equalTo: imageWind.leadingAnchor),
            valueVisible.heightAnchor.constraint(equalToConstant: 20),
            valueVisible.widthAnchor.constraint(equalToConstant: 50),
            
            imageRain.topAnchor.constraint(equalTo: descriptionWeather.bottomAnchor, constant: 15),
            imageRain.leadingAnchor.constraint(equalTo: valueWind.trailingAnchor, constant: 5),
            imageRain.centerYAnchor.constraint(equalTo: valueWind.centerYAnchor),
            imageRain.heightAnchor.constraint(equalToConstant: 40),
            imageRain.widthAnchor.constraint(equalToConstant: 40),
            
            valueRain.topAnchor.constraint(equalTo: descriptionWeather.bottomAnchor, constant: 15),
            valueRain.leadingAnchor.constraint(equalTo: imageRain.trailingAnchor),
            valueRain.centerYAnchor.constraint(equalTo: imageRain.centerYAnchor),
            valueRain.heightAnchor.constraint(equalToConstant: 20),
            valueRain.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    
    //  func setupCell(for data: HeaderData)
    func setupCell(for data: AllWeatherData){
        minMaxWeather.text = data.minMaxWeather
        currentWeatherValue.text = data.currentWeatherValue
        descriptionWeather.text = data.descriptionWeather
        timeRise.text = data.timeRise
        timeSunset.text = data.timeSunset
        generalWeatherInfo.text = data.generalWeatherInfo
        imageVisible.image = data.imageVisible
        valueVisible.text = data.valueVisible
        imageRain.image = data.imageRain
        valueRain.text = data.valueRain
        imageWind.image = data.imageWind
        valueWind.text = data.valueWind
    }
}
