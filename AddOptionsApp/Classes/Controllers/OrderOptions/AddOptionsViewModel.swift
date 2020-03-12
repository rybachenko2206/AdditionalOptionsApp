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
    private var selectedTypes: Set<UKAddConditions> = []
    
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
        if selectedTypes.contains(item.type) && item.isExpandable {
            return OptionExpandableCell.expandedHeight
        } else {
            return OptionExpandableCell.height
        }
    }
    
    func isConditionSelected(_ conditionItem: ConditionItem) -> Bool {
        return selectedTypes.contains(conditionItem.type)
    }
    
    func userDidSelectCondition(at indexPath: IndexPath) {
        guard let item = conditionItem(at: indexPath) else { return }
        if isConditionSelected(item) {
            selectedTypes.remove(item.type)
        } else {
            selectedTypes.insert(item.type)
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
    
    func selectedConditions() -> [ConditionItem] {
        return conditions.filter({ self.selectedTypes.contains($0.type) })
    }
    
}
