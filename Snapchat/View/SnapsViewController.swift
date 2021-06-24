//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 10/06/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            let snap = Snap()
            
            snap.imagenURL = (snapshot.value as! NSDictionary)["imagenURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["descripcion"] as! String
            snap.id = snapshot.key
            snap.imagenID = (snapshot.value as! NSDictionary)["imagenID"] as! String
            self.snaps.append(snap)
            self.tableView.reloadData()
        })
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: {(snapshot) in
            var iterador = 0
            for snap in self.snaps{
                if snap.id == snapshot.key {
                    self.snaps.remove(at: iterador)
                }
                iterador += 1
            }
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "No titnes SNAPS"
        } else {
            let snap = snaps[indexPath.row]
            cell.textLabel?.text = snap.from
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "versnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "versnapsegue" {
            let siguienteVC = segue.destination as! VerSnapViewController
            siguienteVC.snap = sender as! Snap
        }
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnCloseSesion(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
        let listView = storyboard.instantiateViewController(identifier: "ListVC") as! MainViewController
        listView.modalPresentationStyle = .fullScreen
        self.present(listView, animated: true, completion: nil)
    }
}
