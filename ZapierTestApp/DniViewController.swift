//
//  DniViewController.swift
//  ZapierTestApp
//
//  Created by Tobias Lewinzon on 06/02/2020.
//  Copyright © 2020 tobiaslewinzon. All rights reserved.
//

import UIKit

class DniViewController: UIViewController {

    @IBOutlet weak var dniTextField: UITextField!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        let theService = Service()
        let vc = ViewController()
        theService.download(id: dniTextField.text!) { (response) in
            self.person = response
            self.performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.person = person
            vc.dni = dniTextField.text!
        }
    }
    

}
