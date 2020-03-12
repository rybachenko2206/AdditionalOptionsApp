//
//  AddOptionsViewController.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 10.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//


import UIKit
import TPKeyboardAvoiding


class AddOptionsViewController: UIViewController, Storyboardable {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: TPKeyboardAvoidingTableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    // MARK: - Properties
    static var storyboardName: Storyboard {
        return .main
    }
    
    private var viewModel = AddOptionsViewModel()
    
    // MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.backgroundColor
        setupNavigationView()
        setupTableView()
    }
    
    var selectedConditions: (([ConditionItem]) -> Void)?
    
    
    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            guard let conditions = self?.viewModel.selectedConditions(),
                conditions.count > 0
                else { return }
            self?.selectedConditions?(conditions)
        })
    }
    
    
    // MARK: - Private funcs
    private func setupNavigationView() {
        let imgConfig = UIImage.SymbolConfiguration(weight: .medium)
        let closeImage = UIImage(systemName: "xmark", withConfiguration: imgConfig)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = Constants.barButtonItemsTintColor
        closeButton.backgroundColor = Constants.closeButtonColor
        closeButton.setCornerRadius(Constants.barButtonItemsCornerRadius)
        
        doneButton.setCornerRadius(Constants.barButtonItemsCornerRadius)
        doneButton.setTitleColor(Constants.barButtonItemsTintColor, for: .normal)
        doneButton.backgroundColor = Constants.doneButtonColor
        let doneBtnTitle = "Done"
        doneButton.setTitle(doneBtnTitle, for: .normal)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Constants.tableViewBgColor
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0.1, height: 0.1))
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: OptionsHeaderView.height)
        let headerView = OptionsHeaderView(frame: CGRect(origin: .zero, size: size))
        headerView.titleLabel.text = viewModel.titleForHeader(in: 0)
        tableView.tableHeaderView = headerView
        
        tableView.registerCell(OptionExpandableCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureCell(_ cell: OptionExpandableCell, with item: ConditionItem) {
        cell.delegate = self
        cell.optionNameLabel.text = item.title
        cell.infoButton.isHidden = !item.hasInfoButton
        cell.additionalInfoTextField.text = item.additionalInfo
        cell.chekmarkImageView.isHidden = !viewModel.isConditionSelected(item)
        
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attrPlaceholder = NSAttributedString(string: item.textFieldPlaceholder, attributes: attrs)
        cell.additionalInfoTextField.attributedPlaceholder = attrPlaceholder
        
        cell.isExpanded = viewModel.isConditionSelected(item) && item.isExpandable
    }
    
    private func setTextFieldActiveInCell(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OptionExpandableCell,
            let cItem = viewModel.conditionItem(at: indexPath)
            else { return }
        
        if viewModel.isConditionSelected(cItem) && cItem.isExpandable {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration, execute: {
                cell.additionalInfoTextField.becomeFirstResponder()
            })
        } else {
            view.endEditing(true)
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension AddOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let optionItem = viewModel.conditionItem(at: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptionExpandableCell.self)
        configureCell(cell, with: optionItem)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userDidSelectCondition(at: indexPath)
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        setTextFieldActiveInCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }

}

// MARK: - OptionExpandableCellDelegate
extension AddOptionsViewController: OptionExpandableCellDelegate {
    
    func infoButtonTapped(in cell: OptionExpandableCell) {
        AlertsManager.showFeatureInDevelopmentAlert(to: self)
    }
    
    func editedAdditionalInfo(_ info: String?, in cell: OptionExpandableCell) {
        guard let ip = tableView.indexPath(for: cell),
            let item = viewModel.conditionItem(at: ip)
            else { return }

        item.additionalInfo = info
    }
}

// MARK: -
extension AddOptionsViewController {
    
    private struct Constants {
        static let closeButtonSize = CGSize(width: 40, height: 40)
        static let doneButtonSize = CGSize(width: 68, height: 40)
        
        static let barButtonItemsCornerRadius: CGFloat = 8
        
        static let navBarColor = UIColor.clear
        static let closeButtonColor = UIColor.rgba(34, 36, 38)
        static let doneButtonColor = UIColor.rgba(81, 173, 202)
        static let backgroundColor = UIColor.rgba(47, 48, 56)
        static let tableViewBgColor = UIColor.clear
        static let barButtonItemsTintColor = UIColor.white
        
        static let animationDuration: TimeInterval = 0.35
    }
    
}



