//
//  ImageViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 30/05/21.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectContactBtn: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        selectContactBtn.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        selectContactBtn.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectContactTapped(_ sender: Any) {
        selectContactBtn.isEnabled = false
        let imagesFolder = Storage.storage().reference().child("imagenes")
        let imageData = imageView.image!.pngData()!
        
        imagesFolder.child("\(imagenID).jpg").putData(imageData, metadata: nil, completion: {(metadata, error) in
            print ("intentando subir la imagen")
            if error != nil {
                print("Ocurrio un error: \(String(describing: error))")
            } else {
                //self.performSegue(withIdentifier: "selectContactSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! SelectUserViewController
        siguienteVC.imagenURL = sender as! String
        siguienteVC.descrip = descriptionTextField.text!
        siguienteVC.imagenURL = imagenID
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
