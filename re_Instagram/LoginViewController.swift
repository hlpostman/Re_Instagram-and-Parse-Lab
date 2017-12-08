//
//  LoginViewController.swift
//  re_Instagram
//
//  Created by Aristotle on 2017-12-02.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var goToSignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("Successfully logged in user")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            } else {
                print("Error logging in from LoginViewController function onLogIn() with localized description: \(String(describing: error?.localizedDescription))")
            }
        }
    
    }
    @IBAction func onGoToSignUp(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUpSegue", sender: self)
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
