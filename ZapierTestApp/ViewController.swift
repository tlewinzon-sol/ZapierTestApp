//
//  ViewController.swift
//  ZapierTestApp
//
//  Created by Tobias Lewinzon on 06/02/2020.
//  Copyright © 2020 tobiaslewinzon. All rights reserved.
//

import UIKit
import Alamofire

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
    var surname: String
    var age: Int
    
    init(name: String, surname: String, age: Int) {
        self.name = name
        self.surname = surname
        self.age = age
    }
    
    init(dictonary: [String : AnyObject]) {
        name = dictonary["name"] as? String ?? "No name"
        surname = dictonary["surname"] as? String ?? "No surname"
        age = dictonary["age"] as? Int ?? 0
    }
    
    func convertToDictonary() -> [String : AnyObject] {
        return ["name" : name, "surname" : surname, "age" : age] as [String : AnyObject]
    }
}

class Service {
    func uploadI() {
        
    }
}

