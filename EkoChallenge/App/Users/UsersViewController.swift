//
//  UsersViewController.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import UIKit
import CoreData

class UsersViewController: UITableViewController {

    enum SegueIdentifier: String {
        case showDetail
    }
    
    struct PConstant {
        static let userCell = "userCell"
        static let loadingCell = "loadingCell"
    }
    
    var hasNextPage: Bool = false
    var usersRequestState: RequestState = .ready
    var usersRequest: GetUsers?
    var users: [User] = []
    
    @objc func refresh(_ sender: Any) {
        refreshControl?.beginRefreshing()
        reFetch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        renderTableView()
        renderRefreshControl()
        reFetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - API Requests
extension UsersViewController {
    
    func reFetch() {
        users = []
        hasNextPage = true
        usersRequest?.request?.cancel()
        usersRequest = nil
        fetch()
    }
    
    func fetchMoreIfNeeded() {
        guard hasNextPage == true else { return }
        let lastUserId = users.last?.id
        fetch(since: lastUserId)
    }
    
    private func fetch(since: String? = nil) {
        guard usersRequestState != .loading else { return }
        usersRequestState = .loading
        usersRequest = GetUsers(since: since)
        usersRequest?.call { [weak self] (result) in
            guard let ws = self else { return }
            switch result {
            case .success(let response):
                ws.usersRequestState = .success
                ws.hasNextPage = response.data.count > 0
                ws.users += response.data

            case .failure(_ ):
                ws.usersRequestState = .error
                break
            }
            ws.tableView.reloadData()
            ws.endRefreshControl()
        }
    }

}

//MARK: - UIRenderer
extension UsersViewController {
        
    func registerCells() {
        tableView.register(UserCell.self, forCellReuseIdentifier: PConstant.userCell)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: PConstant.loadingCell)
    }
    
    func renderTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
    }
    
    func renderRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func endRefreshControl() {
        if let refreshControl = refreshControl, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

//MARK: - Segue Handler
extension UsersViewController: SegueHandlerType {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(forSegue: segue) {
        case .showDetail:
            guard let destination = segue.destination as? DetailController,
                let user = sender as? User else { return }
            destination.user = user
        }
    }
}
