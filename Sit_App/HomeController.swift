//
//  ViewController.swift
//  Sit_App
//
//  Created by YuHuan on 2021/2/26.
//

import UIKit

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    private let cellId = "cellId"
    
    var accounts: [Account] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return view
    }()
    
    lazy var addAccount: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAccount))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setUpViews()
        fetchAccounts()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setUpViews() {
        self.title = "Home"
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = addAccount
    }
    
    @objc func handleAddAccount() {
        let data = ["note":"lunch","amounts":400] as [String:AnyObject]
        SitApplication.shared.postToServer(path: "/account/new", data: data) { (data) in
            
        }
    }
    
    func fetchAccounts() {
        SitApplication.shared.getFromServer(path: "/accounts", data: nil) { (data) in
            do {
                let accounts = try JSONDecoder().decode([Account].self, from: data)
                self.accounts = accounts
            }catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let account = self.accounts[indexPath.row]
        cell.textLabel?.text = account.amounts
        cell.detailTextLabel?.text = account.note
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = self.accounts[indexPath.row]
        let id = account._id
        // TODO: - show account detail
//        let data = ["id":id] as [String:AnyObject]
//        SitApplication.shared.getFromServer(path: "/account", data: data) { (data) in
//            print(String(data: data, encoding: .utf8))
//        }
    }

}

