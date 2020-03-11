//
//  ConditionItem.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 10.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//


import Foundation


class ConditionItem: Equatable, Hashable {
    let type: UKAddConditions
    var additionalInfo: String?
    
    init(with type: UKAddConditions) {
        self.type = type
    }
    
    // MARK: - Equitable
    static func == (lhs: ConditionItem, rhs: ConditionItem) -> Bool {
        return lhs.type == rhs.type && lhs.additionalInfo == rhs.additionalInfo
    }
    
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(additionalInfo)
    }
    
}





enum UKAddConditions: String, CaseIterable {
    case baggage = "baggage"
    case animal = "animal"
    case conditioner = "conditioner"
    case courier = "courier_delivery"
    case check = "check"
    case engSpeaker = "english_speaker"
    case babyChair = "baby_chair"
    case nonSmoker = "non_smoker"
    case silence = "silence"
    case withSign = "with_sign"
    
    static var allItems: [UKAddConditions] {
        var items  = UKAddConditions.allCases
        
        let appConfig = AppConfigurations()
        if appConfig.hasExtraLuggage {
            items.removeAll(where: { $0 == UKAddConditions.baggage })
        }
        
        return items
    }
    
    var title: String {
        let key = "UKAddConditions.\(self.rawValue).title"
        return key//NSLocalizedString(key, comment: "UKAddConditions title")
    }
    
    var infoText: String? {
        // just not implemented yet
        return nil
    }
    
    var hasInfoButton: Bool {
        switch self {
        case .baggage,
             .animal,
             .courier,
             .withSign:
            return true
        default:
            return false
        }
    }
    
    var placeholder: String? {
        switch self {
        case .animal:
            return "localized with animalPlacechKey"
        case .withSign:
            return "localized with withSignPlacehKey"
        default:
            return nil
        }
    }
    
    var isExpandable: Bool {
        switch self {
        case .animal,
             .withSign:
            return true
        default:
            return false
        }
    }
    
}
