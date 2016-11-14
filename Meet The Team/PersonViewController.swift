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
    let spacing: CGFloat = 10.0 // Spacing between bounds and other objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.blueColor
        let y = (navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        initializeImage(withInitialHeight: y)
        initializeName(withInitialHeight: y)
        initializeTitle(withInitialHeight: y)
        initializeBio()
    }
    
    // MARK: - Initialization
    func initializeImage(withInitialHeight: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: view.frame.width / 4, y: withInitialHeight + spacing,
                                                  width: view.frame.width / 2, height: view.frame.width / 2))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = image
        view.addSubview(imageView)
    }
    
    func initializeName(withInitialHeight: CGFloat) {
        let nameLabel = UILabel(frame: CGRect(x: spacing, y: view.frame.width / 2 + (2*spacing) + withInitialHeight,
                                              width: view.frame.width - (2*spacing), height: 20))
        if let personFirstName = person["firstName"] as? String {
            if let personLastName = person["lastName"] as? String {
                nameLabel.text = personFirstName + " " + personLastName
            }
        }
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.frame.origin.x += view.bounds.width * 2
        view.addSubview(nameLabel)
        animLabel(forLabel: nameLabel)
    }
    
    func initializeTitle(withInitialHeight: CGFloat) {
        let titleLabel = UILabel(frame: CGRect(x: spacing, y: view.frame.width / 2 + (2*spacing) + withInitialHeight + 20, width: view.frame.width - (2*spacing), height: 20))
        if let personTitle = person["title"] as? String {
            titleLabel.text = personTitle
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.frame.origin.x -= view.bounds.width * 2
        titleLabel.font = UIFont(name: "Georgia", size: titleLabel.font.pointSize)
        view.addSubview(titleLabel)
        animLabel(forLabel: titleLabel)
    }
    
    func initializeBio() {
        let bioLabel = PaddedLabel(frame: CGRect(x: spacing, y: view.frame.height / 2, width: view.frame.width - (2*spacing), height:view.frame.height / 2))
        if let personBio = person["bio"] as? String {
            bioLabel.text = personBio
        }
        bioLabel.numberOfLines = 25
        bioLabel.adjustsFontSizeToFitWidth = true
        bioLabel.textColor = UIColor.white
        bioLabel.textAlignment = .left
        bioLabel.layer.borderColor = Colors.pinkColor.cgColor
        bioLabel.layer.borderWidth = 2.0
        bioLabel.layer.cornerRadius = 20.0
        bioLabel.layer.backgroundColor = Colors.blueColor.cgColor
        bioLabel.frame.origin.y += view.bounds.height
        view.addSubview(bioLabel)
        animBio(forLabel: bioLabel)
    }
 
    // MARK: - Animation
    func animLabel(forLabel: UILabel) {
        UIView.animate(withDuration: 2.0, delay: 1.0, usingSpringWithDamping: 0.65, initialSpringVelocity: -5,
                       options: .curveEaseIn, animations: {
                        if(forLabel.frame.origin.x < 0) {
                            forLabel.frame.origin.x += self.view.bounds.width * 2
                        } else if (forLabel.frame.origin.x > self.view.frame.width) {
                            forLabel.frame.origin.x -= self.view.bounds.width * 2
                        }
        }, completion: nil)
    }
    
    func animBio(forLabel: UILabel) {
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: -5,
                       options: .curveEaseIn, animations: {
                        if (forLabel.frame.origin.y > self.view.frame.height) {
                            forLabel.frame.origin.y -= self.view.bounds.height
                        }
        }, completion: nil)
    }
 }
