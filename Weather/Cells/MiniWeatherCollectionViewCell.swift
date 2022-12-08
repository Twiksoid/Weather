//
//  MiniWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Nikita Byzov on 06.12.2022.
//  ячейка для миниатюры погоды

import UIKit

class MiniWeatherCollectionViewCell: UICollectionViewCell {
    
    private lazy var textTimeWeather: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var imageCollectionView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var textWeather: UILabel = {
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
        addSubview(textTimeWeather)
        addSubview(imageCollectionView)
        addSubview(textWeather)
        
        NSLayoutConstraint.activate([
            
            textTimeWeather.topAnchor.constraint(equalTo: topAnchor),
            textTimeWeather.leadingAnchor.constraint(equalTo: leadingAnchor),
            textTimeWeather.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageCollectionView.topAnchor.constraint(equalTo: textTimeWeather.bottomAnchor, constant: -10),
            imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: textWeather.topAnchor, constant: 10),
            
            textWeather.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: -10),
            textWeather.leadingAnchor.constraint(equalTo: leadingAnchor),
            textWeather.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    
    //   func setupCell(for data: MiniData)
    func setupCell(for data: AllWeatherData){
        textTimeWeather.text = data.textTimeWeather
        imageCollectionView.image = data.imageCollectionView
        textWeather.text = data.textWeather
    }
    
    
}
