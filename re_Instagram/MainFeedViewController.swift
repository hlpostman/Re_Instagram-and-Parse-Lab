//
//  MainFeedViewController.swift
//  re_Instagram
//
//  Created by Aristotle on 2017-12-07.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import Parse

class MainFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var newLogin: Bool = false
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatMessageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = ("🌸 \(String(describing: PFUser.current()!.username!))")
        
        fetchMessages()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        sendButton.layer.cornerRadius = 5
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func onSendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["user"] = PFUser.current()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        print("\(String(describing: messages?.count))")
        if messages!.count > 0 {
            if let message = messages?[indexPath.row] {
                cell.messageLabel.text = message["text"] as? String
                if let user = message["user"] as? PFUser {
                    cell.userNameLabel.text = user.username!
                } else {
                    cell.userNameLabel.text = "🙂"
                }
            }
        }
        return cell
    }
    
    @objc func fetchMessages() {
        // Fetch messages from Parse
        print("Timer running")
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
//        query.limit = 2
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if let messages = messages {
                print("saved messages")
                self.messages = messages
                print("\(String(describing: self.messages?.first!["text"]!))")
                self.tableView.reloadData()
            } else {
                print("Error from chat view controller trying to get messages in fetchMessages() function with localized description \"\(error!.localizedDescription)\"")
            }
            }
        
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        print("Tapped logout button")
        PFUser.logOutInBackground { (error: Error?) in
            if (error != nil) {
                print("Error loggin out")
            } else {
                print("Logged user out in background")
            }
        }
//        dismiss works when there was another root view controller, but does not work when persisting user from restart
        // Temporariyl letting newLogin always = true
        let newLogin = true
        if newLogin {
            print("Was a new login.  Just dismissing")
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Was a persisted login - creating new login vc to present on logout")
            let loginViewController = UIViewController() as! LoginViewController
            present(loginViewController, animated: true, completion: nil)
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
