//
//  OptionsHeaderView.swift
//  AddOptionsApp
//
//  Created by Roman Rybachenko on 11.03.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import UIKit

class OptionsHeaderView: UIView {

    // MARK: - Outlets
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    static let height: CGFloat = 34
    
    
    // MARK: - Init funcs
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      Bundle.main.loadNibNamed(String(describing: type(of: self)),
                               owner: self,
                               options: nil)
      self.view.frame = self.bounds
      self.addSubview(self.view)
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      Bundle.main.loadNibNamed(String(describing: type(of: self)),
                               owner: self,
                               options: nil)
      self.view.frame = self.bounds
      self.addSubview(self.view)
    }
    
}
