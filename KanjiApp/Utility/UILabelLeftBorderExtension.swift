//
//  UILabelLeftBorderExtension.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/11.
//  Copyright © 2019年 takahiro. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    func addLeftBorder(width: CGFloat, color: UIColor) {
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: 0, y: 0, width: 2.0, height: self.frame.height)
        leftBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(leftBorder)
    }
}
