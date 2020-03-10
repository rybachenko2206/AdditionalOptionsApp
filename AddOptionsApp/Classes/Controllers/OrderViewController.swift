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
    
    
    // MARK: - Properties
    static var storyboardName: Storyboard {
        return .main
    }
    
    
    // MARK: - Overiden funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Actions

    @IBAction func optionsButtonTapped(_ sender: Any) {
        let optionsVc = AddOptionsViewController.instantiate()
        optionsVc.modalPresentationStyle = .overFullScreen
        self.present(optionsVc, animated: true, completion: nil)
    }
}
