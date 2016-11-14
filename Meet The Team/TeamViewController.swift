//
//  TeamViewController.swift
//  Meet The Team
//
//  Created by Jonathan Chou on 11/12/16.
//  Copyright © 2016 Jonathan Chou. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var json: [[String:AnyObject]]?
    
    var session = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize navigation bar
        title = "Meet the Team"
        
        // Initializes space between each image
        let widthSpace: CGFloat = 10.0
        let heightSpace: CGFloat = 20.0
        // Sets the width to show 3 cells per row (accounting for insets)
        let width = (view.frame.size.width - 2*widthSpace - 20) / 3.0
        // Sets the height to show 4 cells per column (accounting for insets)
        let height = (view.frame.size.height - 3*heightSpace - 30) / 4.0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = widthSpace
        layout.minimumLineSpacing = heightSpace
        layout.itemSize = CGSize(width: width, height: height)
        
        // Initialize the collection view
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "personCell")
        collectionView.backgroundColor = Colors.blueColor
        self.view.addSubview(collectionView)
        
        initializeJSON()
    }
    
    func initializeJSON() {
        let url = Bundle.main.url(forResource: "team", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:AnyObject]]
            json = object
        } catch {
            // Handle error here
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return json!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        cell.backgroundColor = UIColor.clear//UIColor.darkText
        // Customize each cell here
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // move to new viewController

        let vc = PersonViewController()
        vc.modalTransitionStyle = .flipHorizontal
        let cell = collectionView.cellForItem(at: indexPath) as! PersonCell
        vc.image = cell.imageView.image
        if let person = json?[indexPath.row] {
            vc.person = person
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCell(cell: PersonCell, forIndexPath: IndexPath) {
        if let person = json?[forIndexPath.row] {
            if let firstName = person["firstName"] as? String {
                if let lastName = person["lastName"] as? String {
                    cell.nameTextLabel.text = firstName + " " + lastName
                }
            }
            if let title = person["title"] as? String {
                cell.titleTextLabel.text = title
            }
            if let avatar = person["avatar"] as? String {
                if let url = URL(string: avatar) {
                    downloadImage(cell: cell, url: url)

                }
            }
        }
    }
    
    func downloadImage(cell: PersonCell, url: URL) {
        let task = taskForImage(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            // Updates image once download is complete
            DispatchQueue.main.async() {
                cell.imageView.image = UIImage(data: data)
            }
        }
        // Cancels download if cell is still in use
        cell.taskToCancelIfCellIsReused = task
    }
    
    func taskForImage(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) -> URLSessionTask {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
        return task
    }
    

}

