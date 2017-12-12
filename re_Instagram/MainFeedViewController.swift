//
//  MainFeedViewController.swift
//  re_Instagram
//
//  Created by Aristotle on 2017-12-07.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import Parse

class MainFeedViewController: UIViewController {
    @IBOutlet weak var chatMessageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton.layer.cornerRadius = 5
    }

    
    @IBAction func onSendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageTextField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
               
                  self.chatMessageTextField.text = ""
                print("Message saved with text \"\(chatMessage["text"]!)\".  Text field cleared.")
            } else if let error = error {
                print("Message failed to save with error having localized description \"\(error.localizedDescription)\"")
            }
        }
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
