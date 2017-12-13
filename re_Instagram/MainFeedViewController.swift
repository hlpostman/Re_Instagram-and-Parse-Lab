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
    @IBOutlet weak var chatMessageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        sendButton.layer.cornerRadius = 5
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)
        timer.fire()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        return cell
    }
    
    @objc func fetchMessages() {
        // Fetch messages from Parse
        print("Timer running")
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if let messages = messages {
                print("saved messages")
                print("\(String(describing: messages.first))")
            } else {
                print("Error from chat view controller trying to get messages in fetchMessages() function with localized description \"\(error!.localizedDescription)\"")
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
