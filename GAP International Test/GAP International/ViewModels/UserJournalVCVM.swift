//
//  UserJournalVCVM.swift
//  GAP International
//
//  Created by Yogesh on 6/20/23.
//

import UIKit

class UserJournalVCVM: UIViewController {
    
    var username : String?
    var allDetails : [JournalDetails] = []
    var networkClient = NetworkClient()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Register the custom cell class
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        // Add the table view to the view controller's view and set up constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        makeNetworkCall()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}


extension UserJournalVCVM: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //tableView.reloadData()
        print(allDetails.count)
        return allDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.chapterNameLabel.text = allDetails[indexPath.row].ChapterName
        cell.commentLabel.text = allDetails[indexPath.row].Comment
        cell.dateLabel.text = allDetails[indexPath.row].Date
        
        return cell
    }
    
    
}

extension UserJournalVCVM: UITableViewDelegate{
    
}

extension UserJournalVCVM {
    
    func makeNetworkCall(){
        let url2 = getJournalUrl(UserName: self.username ?? "" )
        print("ChpUrl = ", url2)

        var request = URLRequest(url: url2)
        request.httpMethod = "GET"

        networkClient.networkCall(request: request) { data in
            guard let data = data else {
                return
            }

            let decoder = JSONDecoder()
            if let model = try? decoder.decode([JournalDetails].self, from: data) {
                print("Decoding Successful !!!")

                self.allDetails = model

                print("Journal AllDetails = ", self.allDetails)
            } else{
                print("Decoding error")
            }
            
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    
}
