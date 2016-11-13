//
//  PersonViewController.swift
//  Meet The Team
//
//  Created by Jonathan Chou on 11/12/16.
//  Copyright © 2016 Jonathan Chou. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    var image: UIImage!
    var person: [String: AnyObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGray
        
        // Initialize an image view
        let textSpacing:CGFloat = 10.0
        let y = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height

        let imageView = UIImageView(frame: CGRect(x: view.frame.size.width / 4, y: y + textSpacing,
                                                  width: view.frame.size.width / 2, height: view.frame.size.width / 2))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.image
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)
        
        
        let nameLabel = UILabel(frame: CGRect(x: textSpacing, y: view.frame.width / 2 + textSpacing*2 + y, width: view.frame.size.width - textSpacing * 2, height: 20))
        if let personFirstName = person["firstName"] as? String {
            if let personLastName = person["lastName"] as? String {
                nameLabel.text = personFirstName + " " + personLastName
            }
        }
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
        
        let titleLabel = UILabel(frame: CGRect(x: textSpacing, y: view.frame.width / 2 + textSpacing*2 + y + 20, width: view.frame.size.width - textSpacing * 2, height: 20))
        if let personTitle = person["title"] as? String {
            titleLabel.text = personTitle
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.yellow
        titleLabel.textAlignment = .center

        view.addSubview(titleLabel)
        
        
        let bioLabel = UILabel(frame: CGRect(x: textSpacing, y: view.frame.height / 2, width: view.frame.size.width - textSpacing * 2, height: view.frame.size.height / 2))
        if let personBio = person["bio"] as? String {
            bioLabel.text = personBio
        }
        bioLabel.numberOfLines = 25
        bioLabel.adjustsFontSizeToFitWidth = true
        bioLabel.textColor = UIColor.black
        bioLabel.textAlignment = .center
        bioLabel.layer.borderColor = UIColor.black.cgColor
        bioLabel.layer.borderWidth = 1.0
        bioLabel.backgroundColor = UIColor.brown
        view.addSubview(bioLabel)
    }
 
    
 }


