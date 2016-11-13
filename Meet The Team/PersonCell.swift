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
        
        titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width,
                                              height: frame.size.height/6))
        titleTextLabel.textAlignment = .center
        titleTextLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(titleTextLabel)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: frame.size.height / 6, width: frame.size.width, height: frame.size.height * 2/3))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        nameTextLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height * 5/6, width: frame.size.width,
                                          height: frame.size.height/6))
        nameTextLabel.textAlignment = .center
        nameTextLabel.adjustsFontSizeToFitWidth = true

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
