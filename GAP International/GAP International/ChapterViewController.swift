//
//  ChapterViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/20/23.
//

import UIKit

protocol ChpVcDelegate{
    func commentSaved()
}

class ChapterViewController: UIViewController {
    
    var allData : [[String: String]] = []
    var JournalVC = UserJournalVCVM()
    var username: String = ""  {
        didSet{
            print("Val in Chp changed to", username)
        }
    }
    
    var myDetails : [JournalDetails] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Chapter Username:", username)
        
        self.view.backgroundColor = .white
        let path = Bundle.main.path(forResource: "Chapters", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        var conversion : [Dictionary<String, Any>] = dict!["Chapters"] as! [Dictionary<String, Any>]
        
        for i in conversion {
            if let name = i["name"] as? String, let url = i["url"] as? String {
                let modDict = [name:url]
                allData.append(modDict)
            }
        }
        
        tableView.frame  = self.view.bounds
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
        print("Chapter Username:", username)
        
        let url2 = getJournalUrl(UserName: self.username )
        self.JournalVC.username = self.username
        print("ChpUrl = ", url2)
        
        var request = URLRequest(url: url2)
        request.httpMethod = "GET"
        
        networkCall(request: request) { data in
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            if let model = try? decoder.decode([JournalDetails].self, from: data) {
                print("Decoding Successful !!!")
                
                self.myDetails = model
                print("Chp AllDetails = ", self.myDetails)
            } else{
                print("Decoding error")
            }
            
        }
        
    }
}


extension ChapterViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        
        cell.textLabel?.text = allData[indexPath.row].keys.first
        cell.textLabel?.textColor = .systemBlue
        return cell
    }
}

extension ChapterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        print(indexPath.row)
        print("allDetails in ChpVC:", self.myDetails)
        print(self.myDetails.count)
        
        if indexPath.row == 0{
            let mvc = MediaViewController()
            mvc.link = self.allData[indexPath.row].values.first ?? "google.com"
            mvc.username = self.username
            mvc.delegate = self
            mvc.chpName = self.allData[indexPath.row].keys.first!
            self.splitViewController?.showDetailViewController(mvc, sender: self)
        }
        
        else if indexPath.row <= self.myDetails.count {
            print("Index = ", indexPath.row)
            print("Prev index = ", indexPath.row - 1)
            let prev = self.myDetails[indexPath.row - 1]
            print(prev.Comment)
            if prev.Comment != "" {
                let mvc = MediaViewController()
                mvc.delegate = self
                mvc.link = self.allData[indexPath.row].values.first ?? "google.com"
                mvc.username = self.username
                mvc.chpName = self.allData[indexPath.row].keys.first!
                self.splitViewController?.showDetailViewController(mvc, sender: self)
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Please Complete Previous Videos First !!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        else{
            let alert = UIAlertController(title: "Error", message: "Please Complete Previous Videos First !!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}



extension ChapterViewController: ChpVcDelegate{
    func makeNetworkCall(){
        let url2 = getJournalUrl(UserName: self.username )
        self.JournalVC.username = self.username
        print("ChpUrl = ", url2)
        
        var request = URLRequest(url: url2)
        request.httpMethod = "GET"
        
        networkCall(request: request) { data in
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            if let model = try? decoder.decode([JournalDetails].self, from: data) {
                print("Decoding Successful !!!")
                
                self.myDetails = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("Chp AllDetails = ", self.myDetails)
            } else{
                print("Decoding error")
            }
        }
    }
    func commentSaved() {
        makeNetworkCall()
    }
}
