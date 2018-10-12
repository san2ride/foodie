//
//  UIView+Ext.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/12/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}
