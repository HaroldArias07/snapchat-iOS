//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 10/06/21.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var usuarios : [Usuario] = []
    var imagenURL = ""
    var descrip = ""
    var imagenID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("gggggggggg")
        let usuario = usuarios[indexPath.row]
        let snap = [
            "from": Auth.auth().currentUser!.email!,
            "descripcion":descrip,
            "imagenURL":imagenURL,
            "imagenID":imagenID
        ]
        Database.database().reference().child("users").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyboard.instantiateViewController(identifier: "mainVC") as! MainViewController
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
        
        //navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

