//
//  SettingsController.swift
//  Weather
//
//  Created by Nikita Byzov on 27.11.2022.
//

import UIKit

class SettingsController: UIViewController {
    
    private lazy var nameOfGroup: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.allowsEditingTextAttributes = false
        textField.text = Constants.nameOfSection
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: Temp
    
    private lazy var nameOfParamTemp: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.specialGreyForText
        textField.font = .systemFont(ofSize: 16)
        textField.allowsEditingTextAttributes = false
        textField.text = Constants.nameOfTemp
        return textField
    }()
    
    let tempSegmControl: UISegmentedControl = {
        let x = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        x.insertSegment(withTitle: "C", at: 0, animated: false)
        x.insertSegment(withTitle: "F", at: 1, animated: false)
        x.selectedSegmentIndex = 0
        x.selectedSegmentTintColor = UIColor.specialBlue
        x.backgroundColor = UIColor.specialGrey
        x.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        x.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    //MARK: SppedWind
    private lazy var nameOfParamSpeedW: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.specialGreyForText
        textField.font = .systemFont(ofSize: 16)
        textField.allowsEditingTextAttributes = false
        textField.text = Constants.nameOfSpeedW
        return textField
    }()
    
    let sizeSegmControl: UISegmentedControl = {
        let x = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        x.insertSegment(withTitle: "Mi", at: 0, animated: false)
        x.insertSegment(withTitle: "Km", at: 1, animated: false)
        x.selectedSegmentIndex = 0
        x.selectedSegmentTintColor = UIColor.specialBlue
        x.backgroundColor = UIColor.specialGrey
        x.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        x.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    //MARK: Data format
    private lazy var nameOfParamFormatTime: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.specialGreyForText
        textField.font = .systemFont(ofSize: 16)
        textField.allowsEditingTextAttributes = false
        textField.text = Constants.nameOfFormatTime
        return textField
    }()
    
    let timeSegmControl: UISegmentedControl = {
        let x = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        x.insertSegment(withTitle: "12", at: 0, animated: false)
        x.insertSegment(withTitle: "24", at: 1, animated: false)
        x.selectedSegmentIndex = 0
        x.selectedSegmentTintColor = UIColor.specialBlue
        x.backgroundColor = UIColor.specialGrey
        x.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        x.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    //MARK: Mentions
    
    private lazy var nameOfParamMentions: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.specialGreyForText
        textField.font = .systemFont(ofSize: 16)
        textField.allowsEditingTextAttributes = false
        textField.text = Constants.nameOfMentions
        return textField
    }()
    
    let mentionsSegmControl: UISegmentedControl = {
        let x = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        x.insertSegment(withTitle: "On", at: 0, animated: false)
        x.insertSegment(withTitle: "Off", at: 1, animated: false)
        x.selectedSegmentIndex = 0
        x.selectedSegmentTintColor = UIColor.specialBlue
        x.backgroundColor = UIColor.specialGrey
        x.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        x.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    //MARK: Button
    
    private lazy var setNewValuesButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.nameOfSetButton, for: .normal)
        button.backgroundColor = UIColor.specialOrangeButton
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setNewValues), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc private func setNewValues(){
        print("Tapped set")
    }
    
    
    //MARK: StackOfSegmentControl
    private lazy var stekOfSC: UIStackView = {
        let tStack = UIStackView()
        tStack.alignment = .fill
        tStack.spacing = 20
        tStack.distribution = .fill
        tStack.axis = .vertical
        tStack.translatesAutoresizingMaskIntoConstraints = false
        tStack.addArrangedSubview(tempSegmControl)
        tStack.addArrangedSubview(sizeSegmControl)
        tStack.addArrangedSubview(timeSegmControl)
        tStack.addArrangedSubview(mentionsSegmControl)
        return tStack
    }()
    
    //MARK: StackOfNames
    private lazy var stekOfLabels: UIStackView = {
        let tStack = UIStackView()
        tStack.alignment = .fill
        tStack.spacing = 32
        tStack.distribution = .fill
        tStack.axis = .vertical
        tStack.translatesAutoresizingMaskIntoConstraints = false
        tStack.addArrangedSubview(nameOfParamTemp)
        tStack.addArrangedSubview(nameOfParamSpeedW)
        tStack.addArrangedSubview(nameOfParamFormatTime)
        tStack.addArrangedSubview(nameOfParamMentions)
        return tStack
    }()
    
    //MARK: Stack of Stacks
    
    private lazy var stackAll: UIStackView = {
        let tStack = UIStackView()
        tStack.backgroundColor = UIColor.specialBackgroundSettingsWhite
        tStack.alignment = .fill
        tStack.spacing = 32
        tStack.distribution = .fill
        tStack.axis = .horizontal
        tStack.layer.cornerRadius = 10
        tStack.translatesAutoresizingMaskIntoConstraints = false
        tStack.addArrangedSubview(stekOfLabels)
        tStack.addArrangedSubview(stekOfSC)
        return tStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = UIColor.specialBackGroundBlue
        view.addSubview(nameOfGroup)
        view.addSubview(stackAll)
        view.addSubview(setNewValuesButton)
        
        NSLayoutConstraint.activate([
            
            nameOfGroup.bottomAnchor.constraint(equalTo: stackAll.topAnchor, constant: -10),
            nameOfGroup.leadingAnchor.constraint(equalTo: stackAll.leadingAnchor),
            
            stackAll.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackAll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            setNewValuesButton.topAnchor.constraint(equalTo: stackAll.bottomAnchor, constant: 10),
            setNewValuesButton.widthAnchor.constraint(equalTo: stackAll.widthAnchor),
            setNewValuesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
