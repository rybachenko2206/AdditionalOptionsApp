//
//  AppConfigurations.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 10.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation


struct AppConfigurations {
    
    var hasExtraLuggage: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.kIsLuggage)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kIsLuggage)
        }
    }
    
}


extension AppConfigurations {
    
    private struct Keys {
        static let kIsLuggage = "helloWorldRandKeyWithSomeSymbolsBlaBla"
    }
}


