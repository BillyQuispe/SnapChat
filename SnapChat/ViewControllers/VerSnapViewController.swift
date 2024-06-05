//
//  VerSnapViewController.swift
//  SnapChat
//
//  Created by Carlos Velasquez on 3/06/24.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseStorage
import AVFoundation

class VerSnapViewController: UIViewController {
    
    var player: AVPlayer?

    
    @IBOutlet weak var lblMensaje: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap(
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMensaje.text = "Mensaje : " + snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imagenURL), completed : nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnReproducir(_ sender: Any) {
        guard let audioURL = URL(string: snap.audioURL) else {
            return
        }
        player = AVPlayer(url: audioURL)
        player?.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").child(snap.id).removeValue()
       
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete(completion: {(error) in
            print("Se elimino la imagen correctamente")
        })
        Storage.storage().reference().child("audios").child("\(snap.audioID).m4a").delete(completion: {(error) in
            print("Se eliminó el audio correctamente")
        })
        
          }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
