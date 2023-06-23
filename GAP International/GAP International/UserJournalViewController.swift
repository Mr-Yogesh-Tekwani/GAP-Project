//
//  UserJournalViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import UIKit

class UserJournalViewController: UIViewController {
    
    var splitView: UISplitViewController!
    var sidebarVisible = false
    var username: String = "" {
        didSet{
            print("Val in UJ changed to", username)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let titleView = UIImageView (image: UIImage (named: "GAP Icon"))
        titleView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleView
        
        let addButton = UIBarButtonItem(title: "My Journal", style: .plain, target: self, action: #selector(showJournal))
        
        // Set the right bar button item
        navigationItem.rightBarButtonItem = addButton
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Username in UJ: ", username)
        // Create the hamburger button
        let hamburgerButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(toggleSidebar))
        navigationItem.leftBarButtonItem = hamburgerButton
        
        // Create the main content view controller (Video Names)
        let mediaVC = MediaViewController()

        mediaVC.username = username
        let mainNav = UINavigationController(rootViewController: mediaVC)
        mainNav.navigationBar.prefersLargeTitles = true
        
        // Create the sidebar view controller (Chapter Names)
        let chapterVC = ChapterViewController()
        chapterVC.username = username
        mediaVC.delegate = chapterVC
        let sidebarNav = UINavigationController(rootViewController: chapterVC)
        sidebarNav.navigationBar.prefersLargeTitles = true
        
        // Create the split view controller
        splitView = UISplitViewController()
        splitView.viewControllers = [sidebarNav, mainNav]
        splitView.preferredDisplayMode = .oneBesideSecondary
        
        // Add the split view controller as a child view controller
        addChild(splitView)
        view.addSubview(splitView.view)
        splitView.view.frame = view.bounds
        splitView.didMove(toParent: self)
    }
    @objc func toggleSidebar() {
        sidebarVisible = !sidebarVisible

        if sidebarVisible {
            // Show the primary view controller
            splitView.preferredDisplayMode = .oneBesideSecondary

        } else {
            // Hide the primary view controller
            splitView.preferredDisplayMode = .secondaryOnly
        }
        //print(sidebarVisible)
        
    }
    
    
    @objc func showJournal(){
        //let svc = JournalViewController()
        let journalVc = UserJournalVCVM()
        journalVc.username = username
        navigationController?.pushViewController(journalVc, animated: true)
    }
}



