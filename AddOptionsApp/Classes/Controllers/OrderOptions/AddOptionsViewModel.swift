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
    var selectedConditions: Set<ConditionItem> = []
    
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
        if selectedConditions.contains(item) && item.type.isExpandable {
            return OptionExpandableCell.expandedHeight
        } else {
            return OptionExpandableCell.height
        }
    }
    
    func isConditionSelected(_ conditionItem: ConditionItem) -> Bool {
        return selectedConditions.contains(conditionItem)
    }
    
    func userDidSelectCondition(at indexPath: IndexPath) {
        guard let item = conditionItem(at: indexPath) else { return }
        if isConditionSelected(item) {
            selectedConditions.remove(item)
        } else {
            selectedConditions.insert(item)
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        switch section {
        case 0:
            return "AddOptions.Table.Header.Title"
        default:
            assertionFailure("incorrect logic")
            return nil
        }
        
    }
    
}
