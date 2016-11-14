//
//  PaddedLabel.swift
//  Meet The Team
//
//  Created by Jonathan Chou on 11/13/16.
//  Copyright © 2016 Jonathan Chou. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    let padding = UIEdgeInsetsMake(10, 15, 5, 15)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
}
