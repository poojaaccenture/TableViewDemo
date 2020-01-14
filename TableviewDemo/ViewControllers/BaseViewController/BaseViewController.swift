//
//  ViewController.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: CellIdentifier.baseTableViewCell)
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString.init(string: "Refreshing".localized)
        refreshControl.addTarget(self, action:
            #selector(BaseViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var viewModel = BaseViewModel()
    var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initialSetup()
        bind()
        viewModel.getTableData()
    }
}

// MARK:- UI Setup
extension BaseViewController {
    func initialSetup() {
        setTableView()
        setActivityIndicator()
    }
    
    func setTableView()  {
        tableview.dataSource = self
        tableview.addSubview(refreshControl)
        tableview.tableFooterView = UIView()
        view.addSubview(tableview)
        addConstraintToTableView()
    }
    
    func setActivityIndicator() {
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        addConstraintToActivityIndicator()
    }
    
    func addConstraintToActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let xCenter = self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let yCenter = self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        view.addConstraints([ xCenter, yCenter])
    }
    
    func addConstraintToTableView() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        let leading =  self.tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let top =  self.tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let trailing =  self.tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        let bottom =  self.tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        view.addConstraints([leading, top, trailing, bottom])
    }
}

//MARK: IBAction
extension BaseViewController {
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        isRefreshing = true
        viewModel.getTableData()
        refreshControl.endRefreshing()
    }
}

// MARK:- Binding
extension BaseViewController {
    func bind() {
        bindDataDidLoad()
    }
    
    func bindDataDidLoad() {
        viewModel.dataDidLoad.bind {[weak self] (dataDidLoad) in
            guard let self = self else { return }
            if dataDidLoad {
                self.title = self.viewModel.title
                self.tableview.reloadData()
            } else {
                // Show the error msg if its not pull to refresh
                if let errorMsg = self.viewModel.errorMessage, !self.isRefreshing {
                    self.showAlert(with: "Error".localized, msg: errorMsg)
                }
            }
            self.activityIndicator.stopAnimating()
        }
    }
}

//MARK:- TableViewDataSource
extension BaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.baseTableViewCell) as? BaseTableViewCell else { return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: viewModel.cellViewModel(for: indexPath))
        return cell
    }
}

