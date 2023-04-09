//
//  PostViewController.swift
//  ReadHub
//
//  Created by SEAN CHOI on 3/25/23.
//

import UIKit
import ParseSwift

class PostViewController: UIViewController {
    private enum Constants {
        static let feedViewControllerIdentifier = "FeedVC"
        static let feedNavigationControllerIdentifier = "FeedNC"
        static let storyboardIdentifier = "MainViewStoryboard"
    }
    
    var window: UIWindow?

    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var stepperPages: UIStepper!
    @IBOutlet weak var pagesRead: UILabel!
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        pagesRead.text = "\(Int(sender.value))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postTapped(_ sender: Any) {
        view.endEditing(true)
        
        var post = Post()
        
        post.userObjId = User.current?.objectId
        post.title = bookName.text
        post.pages = pagesRead.text
        post.user = User.current
        post.createdAt = Date()
        
        // Save post (async)
        post.save { [weak self] result in

            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")

                    // TODO: Pt 2 - Update user's last posted date
                    // Get the current user
//                    if let currentUser = User.current?.username {
//
//                        // Save updates to the user (async)
//                        currentUser.save { [weak self] result in
//                            switch result {
//                            case .success(let user):
//                                print("✅ User Saved! \(user)")
//
//                                // Switch to the main thread for any UI update
//
//                            case .failure(let error):
//                                self?.showAlert(description: error.localizedDescription)
//                            }
//                        }
                    //}
            
                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
                
                // Create new Alert
                let dialogMessage = UIAlertController(title: "Great!", message: "You've successfully posted", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     DispatchQueue.main.async {
                         let secondStoryBoard = UIStoryboard(name: Constants.storyboardIdentifier, bundle: nil)
                         let secondViewController = secondStoryBoard.instantiateViewController(withIdentifier: Constants.feedViewControllerIdentifier)
                         
                         self?.navigationController?.pushViewController(secondViewController, animated: false)
                     }
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self?.present(dialogMessage, animated: true, completion: nil)
            }
        }
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
