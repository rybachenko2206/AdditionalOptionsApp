//
//  OrderViewController.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 10.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, Storyboardable {
    
    // MARK: - Outlets
    @IBOutlet weak var luggageLabel: UILabel!
    @IBOutlet weak var luggageSwitch: UISwitch!
    
    
    // MARK: - Properties
    static var storyboardName: Storyboard {
        return .main
    }
    
    private var config = AppConfigurations()
    
    
    // MARK: - Overiden funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalization()
        setupConfigurations()
    }
    
    
    // MARK: - Actions

    @IBAction func optionsButtonTapped(_ sender: Any) {
        let optionsVc = AddOptionsViewController.instantiate()
        optionsVc.modalPresentationStyle = .overFullScreen
        self.present(optionsVc, animated: true, completion: nil)
        
        optionsVc.selectedConditions = { [weak self] conditions in
            pl("selected conditions\n\(conditions)")
            
            var message = ""
            conditions.forEach({
                message.append($0.title)
                message.append("\n")
            })
            
            AlertsManager.simpleAlert(title: "Selected conditions", message: message, controller: self)
        }
    }
    
    @IBAction func luggageValueChanged(_ sender: UISwitch) {
        config.hasExtraLuggage = sender.isOn
    }
    
    
    // MARK: - Private funcs
    private func setupConfigurations() {
        luggageSwitch.isOn = config.hasExtraLuggage
    }
    
    private func setupLocalization() {
        luggageLabel.text = NSLocalizedString("OrderVC.LuggageIncluded.Text", comment: "")
    }
    
}
