//
//  MasterViewController.swift
//  UserCV-iOS
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 miguelleonmarti. All rights reserved.
//

import UIKit
import RealmSwift

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let model: MasterModel = MasterModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getUsersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.getNameAndSurname(indexPath.row)
        var stars = ""
        for i in 0...model.getRating(indexPath.row) where i>0 {
            stars += "*"
        }
        cell.detailTextLabel?.text = "Rating: \(stars)"
                        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete) {
            self.model.deleteUser(indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! DetailViewController
                destination.user = self.model.getUser(indexPath.row)
            }
        }
    }
    
}

extension UIImage {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        //self?.image = image
                        self = image
                    }
                }
            }
        }
    }
}

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
