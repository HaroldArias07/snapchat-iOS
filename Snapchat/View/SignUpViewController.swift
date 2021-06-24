//
//  SignUpViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 20/05/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userOrEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let databaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userOrEmailTextField?.text = ""
        passwordTextField?.text = ""
        setUpStyle()
    }
    
    func setUpStyle(){
        signUpButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        let user = userOrEmailTextField.text!
        let password = passwordTextField.text!
        
       
        Auth.auth().createUser(withEmail: user, password: password) { (responseUser, error) in
            if error == nil {
                print("El usuario fue creado exitosamente")
                let userFirebase = Auth.auth().currentUser
                let uid = userFirebase?.uid
                self.storeData(user: user, uid: uid!)
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "User or Password incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func storeData(user: String, uid: String) {
        
        let object:[String: Any] = [
            "id": uid,
            "email": user as NSObject
        ]
        databaseReference.child("users").child(uid).setValue(object)
    }
}
