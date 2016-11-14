//
//  PersonCell.swift
//  Meet The Team
//
//  Created by Jonathan Chou on 11/12/16.
//  Copyright © 2016 Jonathan Chou. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    var titleTextLabel: UILabel!
    var nameTextLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let x = (frame.width - frame.height * 2/3) / 2
        imageView = UIImageView(frame: CGRect(x: x, y: frame.height / 6, width: frame.height * 2/3,
                                              height: frame.height * 2/3))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 6))
        titleTextLabel.textAlignment = .center
        titleTextLabel.numberOfLines = 2
        titleTextLabel.adjustsFontSizeToFitWidth = true
        titleTextLabel.textColor = UIColor.white
        titleTextLabel.font = UIFont(name: "Georgia", size: titleTextLabel.font.pointSize)
        contentView.addSubview(titleTextLabel)
        
        nameTextLabel = UILabel(frame: CGRect(x: 0, y: frame.height * 4/5, width: frame.width,
                                          height: frame.height/5))
        nameTextLabel.textAlignment = .center
        nameTextLabel.adjustsFontSizeToFitWidth = true
        nameTextLabel.textColor = UIColor.white

        contentView.addSubview(nameTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var taskToCancelIfCellIsReused: URLSessionTask? {
        didSet {
            if let taskToCancel = oldValue {
                taskToCancel.cancel()
            }
        }
    }
}
