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
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var ratingTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameTextField.text = self.user?.name
        self.surnameTextField.text = self.user?.surname
        self.ageTextField.text = String(self.user!.age)
        self.dniTextField.text = self.user?.dni
        self.jobTextField.text = self.user?.job
        self.descriptionTextField.text = self.user?.cvDescription
        self.ratingTextField.text = String(self.user!.rating)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {self.view.endEditing(true)}
    
    
    @IBAction func updateTapped(_ sender: UIBarButtonItem) {
        // Check if all fields are not empty
        if (nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dniTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            jobTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ratingTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            
            // Show error message
            Alert.showBasicAlert(on: self, with: "Error", message: "Some fields are empty.")
            
        } else if (Int(ratingTextField.text!.trimmingCharacters(in: .whitespaces))! >= 0 && Int((ratingTextField.text?.trimmingCharacters(in: .whitespaces))!)! <= 10) {
            
            let id = user?.id
            let name = nameTextField.text?.trimmingCharacters(in: .whitespaces)
            let surname = surnameTextField.text?.trimmingCharacters(in: .whitespaces)
            let age = ageTextField.text?.trimmingCharacters(in: .whitespaces)
            let dni = dniTextField.text?.trimmingCharacters(in: .whitespaces)
            let job = jobTextField.text?.trimmingCharacters(in: .whitespaces)
            let description = descriptionTextField.text?.trimmingCharacters(in: .whitespaces)
            let rating = ratingTextField.text?.trimmingCharacters(in: .whitespaces)
            
            try! realm.write {
                
                let user = User()
                user.id = id!
                user.name = name!
                user.surname = surname!
                user.age = Int(age!)!
                user.dni = dni!
                user.job = job!
                user.cvDescription = description!
                user.rating = Int(rating!)!
                
                realm.add(user, update: .all)
            }
            
            // Go back to master
            transitionToMaster()
        } else {
            // Show error message
            Alert.showBasicAlert(on: self, with: "Error", message: "Rating must be from 0 to 10.")
        }
    }
    
    func transitionToMaster(){
        let masterViewController = storyboard?.instantiateViewController(identifier: "Master") as? UINavigationController
        
        view.window?.rootViewController = masterViewController
        view.window?.makeKeyAndVisible()
    }

}
