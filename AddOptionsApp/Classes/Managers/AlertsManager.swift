//
//  AlertsManager.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 11.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation
import UIKit


class AlertsManager {
    
    class func showFeatureInDevelopmentAlert(to viewController: UIViewController?, completion: (() -> Void)? = nil) {
        AlertsManager
            .simpleAlert(title: "Not available",
                         message: "This feature is not implemented",
                         controller: viewController,
                         completion: completion)
    }
    
    class func simpleAlert(title: String,
                           message: String,
                           controller: UIViewController?,
                           completion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let oklAction = UIAlertAction(title: NSLocalizedString("ОК", comment: ""),
                                      style: .default,
                                      handler: { action in
                                        completion?()
        })
        
        alertController.addAction(oklAction)
        controller?.present(alertController, animated: true, completion: nil)
    }
    
}
