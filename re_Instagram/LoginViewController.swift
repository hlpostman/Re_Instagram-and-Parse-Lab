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
    
    @IBOutlet weak var goToSignUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        goToSignUpView.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                print("Successfully logged in user")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            } else {
                print("Error logging in from LoginViewController function onLogIn() with localized description: \(String(describing: error?.localizedDescription))")
                let alertController = UIAlertController(title: "Error Logging In", message: "\(String(describing: error!.localizedDescription))\nPlease try again.", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (alert) in
                    alertController.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
//        let mainFeedViewController = UIViewController() as! MainFeedViewController
//        let segue = UIStoryboardSegue(identifier: "loginSegue", source: self, destination: mainFeedViewController)
//        let vc = segue.destination as! MainFeedViewController
//        vc.newLogin = true
//        print("Set MainFeedViewController newLogin to true")
    
    }
    @IBAction func onGoToSignUp(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUpSegue", sender: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! MainFeedViewController
//        vc.newLogin = true
//        print("Set MainFeedViewController newLogin to true")
//    }
 

}
