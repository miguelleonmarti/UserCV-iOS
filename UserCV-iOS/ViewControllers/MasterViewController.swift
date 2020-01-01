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

        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.tableView.delegate = self
        self.tableView.dataSource = self        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getUsersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row < model.getUsersCount() {
            cell.textLabel?.text = model.getNameAndSurname(indexPath.row)
            cell.detailTextLabel?.text = "Age: \(model.getAge(indexPath.row)) DNI: \(model.getDNI(indexPath.row))"
        } else {
            // Handle non-existing object here
        }
        
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
