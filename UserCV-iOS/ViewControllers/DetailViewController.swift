//
//  DetailViewController.swift
//  UserCV-iOS
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 miguelleonmarti. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var user: User?
    
    let realm = try! Realm()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var dniTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameTextField.text = self.user?.name
        self.surnameTextField.text = self.user?.surname
        self.ageTextField.text = String(self.user!.age)
        self.dniTextField.text = self.user?.dni
        self.jobTextField.text = self.user?.job
        self.titleTextField.text = self.user?.title
        self.descriptionTextField.text = self.user?.cvDescription
    }
    
    
    @IBAction func updateTapped(_ sender: UIBarButtonItem) {
        // Check if all fields are not empty
        if (nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dniTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            jobTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            
            // Show error message
            Alert.showBasicAlert(on: self, with: "Error", message: "Some fields are empty.")
            
        } else {
            
            let id = user?.id
            let name = nameTextField.text?.trimmingCharacters(in: .whitespaces)
            let surname = surnameTextField.text?.trimmingCharacters(in: .whitespaces)
            let age = ageTextField.text?.trimmingCharacters(in: .whitespaces)
            let dni = dniTextField.text?.trimmingCharacters(in: .whitespaces)
            let job = jobTextField.text?.trimmingCharacters(in: .whitespaces)
            let title = titleTextField.text?.trimmingCharacters(in: .whitespaces)
            let description = descriptionTextField.text?.trimmingCharacters(in: .whitespaces)
            
            try! realm.write {
                
                let user = User()
                user.id = id!
                user.name = name!
                user.surname = surname!
                user.age = Int(age!)!
                user.dni = dni!
                user.job = job!
                user.title = title!
                user.cvDescription = description!
                
                realm.add(user, update: .all)
            }
            
            // Go back to master
            transitionToMaster()
        }
    }
    
    func transitionToMaster(){
        let masterViewController = storyboard?.instantiateViewController(identifier: "Master") as? UINavigationController
        
        view.window?.rootViewController = masterViewController
        view.window?.makeKeyAndVisible()
    }

}
