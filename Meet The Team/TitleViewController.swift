//
//  TitleViewController.swift
//  Meet The Team
//
//  Created by Jonathan Chou on 11/13/16.
//  Copyright © 2016 Jonathan Chou. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.blueColor
        
        initializeLogo()
        initializeButton()
    }
    
    // Hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        animButton()
    }
    
    // Show navigation bar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        button.alpha = 0.0
    }
    
    // MARK: - Initialization
    func initializeLogo() {
        let logo = UIImageView(image: #imageLiteral(resourceName: "logo"))
        logo.frame = CGRect(x: view.frame.width / 4, y: view.frame.height / 4, width: view.frame.width / 2, height: view.frame.width / 2)
        logo.contentMode = .scaleAspectFill
        logo.layer.cornerRadius = 40.0
        logo.layer.borderColor = UIColor.white.cgColor
        logo.layer.borderWidth = 3.0
        view.addSubview(logo)
    }
    
    func initializeButton() {
        button = UIButton(frame: CGRect(x: view.frame.width / 4, y: view.frame.height * 3/4, width: view.frame.width / 2, height: 50))
        button.setTitle("Meet the Team", for: .normal)
        button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3.0
        button.backgroundColor = Colors.pinkColor
        button.alpha = 0.0
        view.addSubview(button)
    }
    
    // Move to team view controller
    func buttonTouch(sender: UIButton!) {
        let vc = TeamViewController()
        vc.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Animation
    func animButton() {
        UIView.animate(withDuration: 0.75, delay: 0.75, options: .curveEaseIn, animations: {
            self.button.alpha = 1.0
        }, completion: nil)
    }
}
