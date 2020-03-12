//
//  AddOptionsViewModel.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 10.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation
import UIKit


class AddOptionsViewModel {
    
    // MARK: - Properties
    private let conditions: [ConditionItem]
    private var selectedConditions: Set<String> = []
    
    // MARK: - Init funcs
    init() {
        self.conditions = UKAddConditions.allItems.compactMap({ ConditionItem(with: $0) })
    }
    
    
    // MARK: - Public funcs
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return conditions.count
    }
    
    func conditionItem(at indexPath: IndexPath) -> ConditionItem? {
        return conditions[safe: indexPath.row]
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        guard let item = conditionItem(at: indexPath) else { return 0 }
        if selectedConditions.contains(item.type.rawValue) && item.isExpandable {
            return OptionExpandableCell.expandedHeight
        } else {
            return OptionExpandableCell.height
        }
    }
    
    func isConditionSelected(_ conditionItem: ConditionItem) -> Bool {
        return selectedConditions.contains(conditionItem.type.rawValue)
    }
    
    func userDidSelectCondition(at indexPath: IndexPath) {
        guard let item = conditionItem(at: indexPath) else { return }
        if isConditionSelected(item) {
            selectedConditions.remove(item.type.rawValue)
        } else {
            selectedConditions.insert(item.type.rawValue)
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        switch section {
        case 0:
            return NSLocalizedString("AddOptions.Table.Header.Title", comment: "Options header title")
        default:
            assertionFailure("incorrect logic")
            return nil
        }
    }
    
}
