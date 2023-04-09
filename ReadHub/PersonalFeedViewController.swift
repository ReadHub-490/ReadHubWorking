//
//  FeedViewController.swift
//  ReadHub
//
//  Created by Chinmay Bansal on 4/3/23.
//

import UIKit
import ParseSwift

class PersonalFeedViewController: UIViewController {
 
    @IBOutlet weak var personalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personalTableView.delegate = self
        personalTableView.dataSource = self
        personalTableView.allowsSelection = false

        personalTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        
    }
    private let refreshControl = UIRefreshControl()
    
    private var posts = [Post]() {
        didSet {
            // Reload table view data any time the posts variable gets updated.
            personalTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryPosts()
    }
    
    private func queryPosts(completion: (() -> Void)? = nil) {
        // TODO: Pt 1 - Query Posts
        // https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/2%20-%20Finding%20Objects.xcplaygroundpage/Contents.swift#L66

        // 1. Create a query to fetch Posts
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the posts by descending order based on the created at date
        // 4. TODO: Pt 2 - Only include results created yesterday onwards
        // 5. TODO: Pt 2 - Limit max number of returned posts
        
        
        // Get the date for yesterday. Adding (-1) day is equivalent to subtracting a day.
        // NOTE: `Date()` is the date and time of "right now".
        
        let query = Post.query("userObjId" == User.current?.objectId)
            .include("user")
            .order([.descending("createdAt")])
            .limit(20) // <- Limit max number of returned posts to 10

        // Find and return posts that meet query criteria (async)
        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                // Update the local posts property with fetched posts
                self?.posts = posts
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }

            // Call the completion handler (regardless of error or success, this will signal the query finished)
            // This is used to tell the pull-to-refresh control to stop refresshing
            completion?()
        }
    }
    
    @objc private func onPullToRefresh() {
        refreshControl.beginRefreshing()
        queryPosts { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    
}

extension PersonalFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalPostCell", for: indexPath) as? PersonalPostCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

extension PersonalFeedViewController: UITableViewDelegate { }
