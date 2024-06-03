//
//  ViewController.swift
//  SnapChat
//
//  Created by Carlos Velasquez on 20/05/24.
//

    import UIKit
    import FirebaseAuth
    import GoogleSignIn
    import FirebaseCore
    import FirebaseDatabase

    class iniciarSesionViewController: UIViewController {

        @IBOutlet weak var googlebutton: GIDSignInButton!
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
         
        }

            @IBAction func iniciarSesionTapped(_ sender: Any) {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                    print("Intentando Iniciar Sesión")
                    if error != nil{
                        print("Se presento el siguiente error: \(error)")
                        let alerta = UIAlertController(title: "Inicio de sesión", message: "Credenciales incorrectas", preferredStyle: .alert)
                        let btnOK = UIAlertAction(title: "Crear", style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "registrarSegue", sender: nil)
                        })
                        let btnCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: { (UIAlertAction) in })
                        alerta.addAction(btnOK)
                        alerta.addAction(btnCancelar)
                        self.present(alerta, animated: true, completion: nil)
                        
                    }else{
                        print("Inicio de sesión exitoso")
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                }
            }
        
        @IBAction func iniciarSesionGoogleTapped(_ sender: Any) {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

               // Crear el objeto de configuración de inicio de sesión de Google.
               let config = GIDConfiguration(clientID: clientID)
               GIDSignIn.sharedInstance.configuration = config

               // Iniciar el flujo de inicio de sesión.
               GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
                   guard error == nil else {
                       print("Error al iniciar sesión con Google: \(error!.localizedDescription)")
                       return
                   }

                   guard let user = result?.user,
                         let idToken = user.idToken?.tokenString
                   else {
                       print("No se pudo obtener la información del usuario.")
                       return
                   }

                   let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                  accessToken: user.accessToken.tokenString)

                   // Autenticar con Firebase.
                   Auth.auth().signIn(with: credential) { result, error in
                       if let error = error {
                           print("Error al autenticar con Firebase: \(error.localizedDescription)")
                       } else {
                           print("Inicio de sesión con Google exitoso.")
                       }
                   }
               }
    }
    }

