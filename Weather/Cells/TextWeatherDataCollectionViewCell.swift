//
//  TextWeatherDataCollectionViewCell.swift
//  Weather
//
//  Created by Nikita Byzov on 06.12.2022.
//

import UIKit

class TextWeatherDataCollectionViewCell: UICollectionViewCell {
    
    private lazy var dataWeather: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageWeather: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var vetPercent: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var descriptionWeather: UILabel = {
        let text = UILabel()
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var degreesseData: UILabel = {
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
        addSubview(dataWeather)
        addSubview(imageWeather)
        addSubview(vetPercent)
        addSubview(descriptionWeather)
        addSubview(degreesseData)
        
        NSLayoutConstraint.activate([
            
            dataWeather.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dataWeather.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dataWeather.bottomAnchor.constraint(equalTo: imageWeather.topAnchor, constant: -5),
            
            imageWeather.topAnchor.constraint(equalTo: dataWeather.bottomAnchor, constant: 5),
            imageWeather.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageWeather.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            imageWeather.heightAnchor.constraint(equalToConstant: 40),
            imageWeather.widthAnchor.constraint(equalToConstant: 40),
            
            vetPercent.topAnchor.constraint(equalTo: dataWeather.bottomAnchor, constant: 10),
            vetPercent.leadingAnchor.constraint(equalTo: imageWeather.trailingAnchor, constant: 5),
            vetPercent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            vetPercent.widthAnchor.constraint(equalToConstant: 40),
            vetPercent.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionWeather.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            descriptionWeather.leadingAnchor.constraint(equalTo: vetPercent.trailingAnchor, constant: 5),
            descriptionWeather.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionWeather.widthAnchor.constraint(equalToConstant: CGFloat(frame.width / 2)),
            descriptionWeather.heightAnchor.constraint(equalToConstant: 20),
            
            degreesseData.centerYAnchor.constraint(equalTo: descriptionWeather.centerYAnchor),
            degreesseData.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            degreesseData.widthAnchor.constraint(equalToConstant: 80),
            degreesseData.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    
    // func setupCell(for data: TextData)
    func setupCell(for data: AllWeatherData){
        dataWeather.text = data.dataWeather
        imageWeather.image = data.imageWeather
        vetPercent.text = data.vetPercent
        //    descriptionWeather.text = data.descriptionWeather
        descriptionWeather.text = data.extraTextWeather
        degreesseData.text = data.degreesseData
    }
    
}
