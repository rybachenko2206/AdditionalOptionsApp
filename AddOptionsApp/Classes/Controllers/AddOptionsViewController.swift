//
//  AddOptionsViewController.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 10.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import UIKit

class AddOptionsViewController: UIViewController, Storyboardable {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    // MARK: - Properties
    static var storyboardName: Storyboard {
        return .main
    }
    
    
    // MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.backgroundColor
        setupNavigationView()
        setupTableView()
    }
    
    
    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        pf()
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
        doneButton.setTitle("Done", for: .normal)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Constants.tableViewBgColor
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0.1, height: 0.1))
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView
    }
}


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
    }
    
}
