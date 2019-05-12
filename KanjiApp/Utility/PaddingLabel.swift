//
//  PaddingLabel.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/11.
//  Copyright © 2019年 takahiro. All rights reserved.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

}
