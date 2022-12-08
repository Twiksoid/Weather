//
//  TextPicker.swift
//  Weather
//
//  Created by Nikita Byzov on 29.11.2022.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    func getText(in viewController: UIViewController, completion: ((_ text: String)->Void)? ) {
        let alertController = UIAlertController(title: Constants.alarmTownName, message: nil, preferredStyle: .alert)
        
        alertController.addTextField {
            textFiel in textFiel.placeholder = Constants.alarmTownText
        }
        
        let actionOK = UIAlertAction(title: Constants.alarmTownOk, style: .default) { alert in
            if let text = alertController.textFields?[0].text, text != "" {
                completion?(text)
            }
        }
        
        let actionCansel = UIAlertAction(title: Constants.alarmTownCansel, style: .cancel)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCansel)
        
        viewController.present(alertController, animated: true)
    }
}
