//
//  HomeViewController.swift
//  Instagram
//
//  Created by Noureddine Youssfi on 3/5/16.
//  Copyright © 2016 Noureddine Youssfi. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        loadMoreData()
        tableView.reloadData()
        self.refreshControl()
        
        
    }

    func refreshControl(){
        self.refresh = UIRefreshControl()
        refresh.addTarget(self, action: "refreshControlAction", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refresh)
        self.refresh.backgroundColor = UIColor.whiteColor()
        self.refresh.tintColor = UIColor.lightGrayColor()
        self.refresh.endRefreshing()
        
        
    }
    
    func refreshControlAction(){
        self.loadPosts()
        self.tableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        posts = loadPosts()
        tableView.reloadData()
        self.refreshControl()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.posts {
            return posts.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostsCell", forIndexPath: indexPath) as! PostsCell

        if (posts != nil) {
            let object = posts![indexPath.row]
            
            cell.infoObject = object
            
        }
        return cell
    }
    
    
    
    /*===========DATA==============*/
    func loadMoreData() {
        // construct PFQuery and get data from Parse
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // print(posts)
                self.posts = posts
                self.tableView.reloadData()
                
                // is this called?
            } else {
                print("ERROR: unable to get photos from parse")
            }
        }
        
    }
    /*===============================*/
    
    func loadPosts() -> [PFObject]? {
        
        var thePosts: [PFObject]?
        let query = PFQuery(className:"Post")
        //query.whereKey("name", equalTo: "\(name)")
//        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            thePosts = objects
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Points In Time.")
                self.posts = objects
                self.tableView.reloadData()
                
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        print(object)
                    }
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        return thePosts
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
