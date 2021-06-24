//
//  LoginViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 20/05/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userOrEmailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userOrEmailTextField?.text = "test2@gmail.com"
        passwordTextField?.text = "tecsup"
        setUpStyle()
    }
    
    func setUpStyle(){
        loginButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickLogIn(_ sender: Any) {
        let user = userOrEmailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: user, password: password) { (responseUser, error) in
            if error == nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "User or Password incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
