//
//  ViewController.swift
//  ZapierTestApp
//
//  Created by Tobias Lewinzon on 06/02/2020.
//  Copyright © 2020 tobiaslewinzon. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase

class ViewController: UIViewController {
    
    var person: Person?
    var dni: String?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var dniLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func saveButton(_ sender: Any) {
        let theService = Service()
        let person = Person(name: nameTextField.text!, surname: surnameTextField.text!, age: Int(ageTextField.text!)!, dni: dniLabel.text!)
        theService.upload(person: person)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setup() {
        if let person = person {
            nameTextField.text = person.name
            surnameTextField.text = person.surname
            ageTextField.text = "\(person.age)"
            dniLabel.text = person.dni
            dniLabel.textColor = .green
        } else {
            dniLabel.text = dni!
            dniLabel.textColor = .red
        }
    }

}

struct Person {
    var name: String
    var dni: String
    var surname: String
    var age: Int
    
    init(name: String, surname: String, age: Int, dni: String) {
        self.name = name
        self.surname = surname
        self.age = age
        self.dni = dni
    }
    
    init(dictonary: [String : AnyObject]) {
        name = dictonary["name"] as? String ?? "No name"
        surname = dictonary["surname"] as? String ?? "No surname"
        age = dictonary["age"] as? Int ?? 0
        dni = dictonary["dni"] as? String ?? "XX.XXX.XXX"
    }
    
    func convertToDictonary() -> [String : AnyObject] {
        return ["name" : name, "surname" : surname, "age" : age, "dni" : dni] as [String : AnyObject]
    }
}

class Service {
    func upload(person: Person) {
        let refDatabase = Database.database().reference()
        refDatabase.child("people").child(person.dni).setValue(person.convertToDictonary())
    }
    
    func download(id: String, completion: @escaping ((Person?) -> Void)) {
        let refDatabase = Database.database().reference()
        var theResult: Person?
        refDatabase.child("people").child(id).observe(.value) { (DataSnapshot) in
            if let data = DataSnapshot.value as? [String : AnyObject] {
                let person = Person(dictonary: data)
                theResult = person
            }
            completion(theResult)
        }
    }
}

