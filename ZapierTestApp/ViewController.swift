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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func saveButton(_ sender: Any) {
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
        refDatabase.child(person.dni).setValue(person.convertToDictonary())
    }
    
    func download(id: String, completion: @escaping ((Person?) -> Void)) {
        let refDatabase = Database.database().reference()
        var theResult: Person?
        refDatabase.child(id).observe(.value) { (DataSnapshot) in
            if let data = DataSnapshot.value as? [String : AnyObject] {
                let person = Person(dictonary: data)
                theResult = person
            }
            completion(theResult)
        }
    }
}

