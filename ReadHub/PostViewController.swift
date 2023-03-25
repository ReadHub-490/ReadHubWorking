//
//  PostViewController.swift
//  ReadHub
//
//  Created by SEAN CHOI on 3/25/23.
//

import UIKit

class PostViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
