//
//  ViewController.swift
//  Meet The Team
//
//  Created by Jonathan Chou on 11/12/16.
//  Copyright © 2016 Jonathan Chou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var json: Array<Any>!
    
    var session = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 15.0 // space between images
        let width = (view.frame.size.width - 2*space - 20) / 3.0
        let height = (view.frame.size.height - 3*space - 30) / 4.0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        layout.itemSize = CGSize(width: width, height: height)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "personCell")
        self.view.addSubview(collectionView)
        
        initializeJSON()
    }
    
    func initializeJSON() {
        let url = Bundle.main.url(forResource: "team", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Array<Any>
            json = object
        } catch {
            // Handle error here
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return json.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        cell.backgroundColor = UIColor.orange
        // customize each cell here
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // move to new viewController
    }
    
    func configureCell(cell: PersonCell, forIndexPath: IndexPath) {
        if let person = json[forIndexPath.row] as? [String: AnyObject] {
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
    
    func taskForImage(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) -> URLSessionTask {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
        return task
    }
    
    func downloadImage(cell: PersonCell, url: URL) {
        let task = taskForImage(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.imageView.image = UIImage(data: data)
            }
        }
        // Cancels download if cell is still in use
        cell.taskToCancelIfCellIsReused = task
    }
}

