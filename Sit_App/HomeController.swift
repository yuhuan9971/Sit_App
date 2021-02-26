//
//  ViewController.swift
//  Sit_App
//
//  Created by YuHuan on 2021/2/26.
//

import UIKit

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    private let cellId = "cellId"
    
    var accounts: [[String: AnyObject]] = [] {
        didSet {
            self.tableView.reloadData()
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
        SitApplication().test()
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
        print("handle add account")
    }
    
    func fetchAccounts() {
        SitApplication().getFromServer(path: "/accounts", data: nil) { (data) in
            print(String(data: data, encoding: .utf8))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = "Little sit and Chueng"
        return cell
    }


}

