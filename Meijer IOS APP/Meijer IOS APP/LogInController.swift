//
//  LogInController.swift
//  Meijer IOS APP
//
//  Created by Farhadul Fahim on 2/14/22.
//

import Foundation
import UIKit


class LoginInController: UIViewController {
    
    @IBAction func createButton(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccountSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

