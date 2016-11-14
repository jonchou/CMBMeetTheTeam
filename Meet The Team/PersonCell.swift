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
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeImageView()
        initializeTitle()
        initializeName()
        initializeActivityIndicator()
    }
    
    // MARK: - Initialization
    func initializeImageView() {
        let x = (frame.width - frame.height * 2/3) / 2
        imageView = UIImageView(frame: CGRect(x: x, y: frame.height / 6, width: frame.height * 2/3,
                                              height: frame.height * 2/3))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    func initializeTitle() {
        titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 6))
        titleTextLabel.textAlignment = .center
        titleTextLabel.numberOfLines = 2
        titleTextLabel.adjustsFontSizeToFitWidth = true
        titleTextLabel.textColor = UIColor.white
        titleTextLabel.font = UIFont(name: "Georgia", size: titleTextLabel.font.pointSize)
        contentView.addSubview(titleTextLabel)
    }
    
    func initializeName() {
        nameTextLabel = UILabel(frame: CGRect(x: 0, y: frame.height * 4/5, width: frame.width,
                                              height: frame.height/5))
        nameTextLabel.textAlignment = .center
        nameTextLabel.adjustsFontSizeToFitWidth = true
        nameTextLabel.textColor = UIColor.white
        contentView.addSubview(nameTextLabel)
    }
    
    func initializeActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = contentView.center
        activityIndicator.hidesWhenStopped = true
        contentView.addSubview(activityIndicator)
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
