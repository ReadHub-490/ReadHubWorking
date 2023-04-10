//
//  FollowingViewController.swift
//  ReadHub
//
//  Created by Colton Scott on 3/25/23.
//

import UIKit
import ParseSwift

class FollowingViewController: UIViewController {
    
    @IBOutlet weak var userNamefield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    private var ObjectIDUser: String?
    
    @IBAction func addButton(_ sender: Any) {
        var currUser = User.current
        
        if let username = userNamefield.text, username.isEmpty {
            let alertController = UIAlertController(title: "Alert", message: "Ensure all fields are correctly filled", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                print("OK button tapped")
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            print("username or password is nil!")
            return
        }
        let usernameText = userNamefield.text!
        print(usernameText)
        
        let query = User.query("username" == usernameText)
            .include("objectId")
            .limit(1)
        
        query.find { [weak self] result in
            switch result {
            case .success(let userQuery):
                if (userQuery.isEmpty) {
                    let alertController = UIAlertController(title: "Alert", message: "User could not be found", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) {
                        (action: UIAlertAction!) in
                        print("OK button tapped")
                    }
                    alertController.addAction(OKAction)
                    self?.present(alertController, animated: true, completion: nil)
                    print("username or password is nil!")
                    return
                } else {
                    self?.ObjectIDUser = userQuery[0].objectId
                    
                    if let currentFollowing = User.current?.following,
                       let objectIDUser = self?.ObjectIDUser,
                       currentFollowing.contains(objectIDUser) {
                        let alertController = UIAlertController(title: "Alert", message: "You already follow this user", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) {
                            (action: UIAlertAction!) in
                            print("OK button tapped")
                        }
                        alertController.addAction(OKAction)
                        self?.present(alertController, animated: true, completion: nil)
                        print("username or password is nil!")
                        return
                    } else {
                        var user = User(objectId: User.current?.objectId)
                        var followArr = currUser?.followingIds ?? []
                        followArr.append((self?.ObjectIDUser)!)
                        user.followingIds = followArr
                        
                        user.save { [weak self] result in
                            switch result {
                            case .success:
                                print("hello!!")
                                print(self?.ObjectIDUser)
                                
                            case .failure(let error):
                                self?.showAlert(description: error.localizedDescription)
                            }
                        }
                    }
                        
                }
                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
}

extension FollowingViewController {
    //  @IBAction func cancelToFollowingViewController(_ segue: UIStoryboardSegue) {
    //  }
    
    
}
