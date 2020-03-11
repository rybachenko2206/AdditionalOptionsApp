//
//  OptionExpandableCell.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 11.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import UIKit

protocol OptionExpandableCellDelegate: class {
    func infoButtonTapped(in cell: OptionExpandableCell)
}


class OptionExpandableCell: UITableViewCell, ReusableCell {
    
    // MARK: - Outlets
    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var additionalInfoTextField: UITextField!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var chekmarkImageView: UIImageView!
    
    @IBOutlet weak var separatorViewLeftConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    static let expandedHeight: CGFloat = 120
    static var height: CGFloat {
        return 60
    }
    
    var isExpanded: Bool = false {
        didSet {
            textFieldContainerView.isHidden = !isExpanded
            
            let leftOffset = isExpanded ? Constants.separatoLeftOffsetExpanded : Constants.separatoLeftOffsetCollapsed
            separatorViewLeftConstraint.constant = leftOffset
        }
    }
    
    weak var delegate: OptionExpandableCellDelegate?
    
    
    // MARK: - Overriden funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    
    // MARK: - Actions
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        delegate?.infoButtonTapped(in: self)
    }
    
    
    // MARK: - Private funcs
    private func setupUI() {
        let imgConfig = UIImage.SymbolConfiguration(weight: .semibold)
        let infoImage = UIImage(systemName: Constants.infoImgName, withConfiguration: imgConfig)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.tintColor = Constants.infoImageColor
    }
    
}


extension OptionExpandableCell {
    private struct Constants {
        static let infoImgName = "info.circle"
        static let infoImageColor = UIColor.rgba(244, 212, 107)
        static let separatoLeftOffsetCollapsed: CGFloat = 15
        static let separatoLeftOffsetExpanded: CGFloat = 49
    }
}
