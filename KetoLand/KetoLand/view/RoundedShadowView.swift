//
//  RoundedShadowView.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/12/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius  = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor   = UIColor.black.cgColor
        self.layer.shadowRadius  = 5.0
        self.layer.shadowOffset  = CGSize(width: 0, height: 5)
    }
}
