//
//  ViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 20/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeSessionTapped(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyboard.instantiateViewController(identifier: "mainVC") as! MainViewController
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }
    
    
    
}

