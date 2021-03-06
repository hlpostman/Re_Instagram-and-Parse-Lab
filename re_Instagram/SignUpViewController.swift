//
//  SignUpViewController.swift
//  re_Instagram
//
//  Created by Aristotle on 2017-12-02.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var goToLoginButton: UIButton!
    
    @IBOutlet weak var goToLoginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        goToLoginView.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }

    @IBAction func onSignUp(_ sender: Any) {
        if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Username and Password Required", message: "Please enter both a username and password.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        } else {
            let newUser = PFUser()
            newUser.username = usernameTextField.text
            newUser.password = passwordTextField.text
            
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if success {
                    print("Created a user")
                    self.performSegue(withIdentifier: "signUpSegue", sender: self)
                } else {
                    print("Error from completion block in SignUpViewController function onSignUp().  Error localized description: \(error!.localizedDescription)")
    //                if error?.code  == 202 {
    //                     Add code to show user alert
    //                      Issue with block expecting Error not NSError, so no
    //                .code getter available...
    //                    print("Username is taken")
    //                }
                    let alertController = UIAlertController(title: "Error Signing Up", message: "\(String(describing: error!.localizedDescription))\nPlease try again.", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(tryAgainAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func onGoToLogin(_ sender: Any) {
        performSegue(withIdentifier: "goToLoginSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
