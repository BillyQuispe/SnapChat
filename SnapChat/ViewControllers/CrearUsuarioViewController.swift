//
//  CrearUsuarioViewController.swift
//  SnapChat
//
//  Created by Carlos Velasquez on 31/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CrearUsuarioViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCrearCuenta(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { [weak self] user, error in
                   guard let self = self else { return }
                   
                   if let error = error {
                       print("Se presentó el siguiente error al crear el usuario: \(error.localizedDescription)")
                       // Aquí podrías mostrar una alerta al usuario informando del error
                       return
                   }
                   
                   print("El usuario fue creado exitosamente")
                   Database.database().reference().child("usuarios").child  (user!.user.uid).child("email").setValue(user!.user.email)
                   let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario: \(self.emailTextField.text!) se creó correctamente.", preferredStyle: .alert)
                   let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                       // Una vez creado el usuario, puedes navegar a la siguiente vista si lo deseas
                       // Por ejemplo:
                       self.performSegue(withIdentifier: "inicioSegue", sender: nil)
                   })
                   alerta.addAction(btnOK)
                   self.present(alerta, animated: true, completion: nil)
               })
           }
}
