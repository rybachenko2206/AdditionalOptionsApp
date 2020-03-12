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
    
    var title: String {
        let key = "UKAddConditions.\(type.rawValue).title"
        return NSLocalizedString(key, comment: "UKAddConditions title")
    }
    
    var infoText: String? {
        // just not implemented yet
        return nil
    }
    
    var hasInfoButton: Bool {
        switch type {
        case .baggage,
             .animal,
             .courier,
             .withSign:
            return true
        default:
            return false
        }
    }
    
    var textFieldPlaceholder: String {
        switch type {
        case .animal:
            return NSLocalizedString("UKAddCondition.Animal.TextFieldPlaceholder" , comment: "")
        case .withSign:
            return NSLocalizedString("UKAddCondition.WithSign.TextFieldPlaceholder" , comment: "")
        default:
            return ""
        }
    }
    
    var isExpandable: Bool {
        switch type {
        case .animal,
             .withSign:
            return true
        default:
            return false
        }
    }
    
}





enum UKAddConditions: String, CaseIterable {
    case baggage = "baggage"
    case animal = "animal"
    case conditioner = "conditioner"
    case courier = "courier_delivery"
    case check = "check" // Does not used
    case engSpeaker = "english_speaker"
    case babyChair = "baby_chair"
    case nonSmoker = "non_smoker"
    case silence = "silence"
    case withSign = "with_sign"
    
    static var allItems: [UKAddConditions] {
//        var items = UKAddConditions.allCases
        var items = [
            UKAddConditions.babyChair,
            UKAddConditions.courier,
            UKAddConditions.nonSmoker,
            UKAddConditions.baggage,
            UKAddConditions.animal,
            UKAddConditions.conditioner,
            UKAddConditions.engSpeaker,
            UKAddConditions.withSign,
            UKAddConditions.silence
        ]
        
        let appConfig = AppConfigurations()
        if appConfig.hasExtraLuggage {
            items.removeAll(where: { $0 == UKAddConditions.baggage })
        }
        
        return items
    }
    
}
