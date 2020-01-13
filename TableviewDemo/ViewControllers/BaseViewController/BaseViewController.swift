//
//  ViewController.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: CellIdentifier.baseTableViewCell.rawValue)
        return tableView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(BaseViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    var viewModel = BaseViewModel()
    
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
        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.addSubview(refreshControl)
        self.view.addSubview(tableview)
        addConstraintToTableView()
    }
    
    func setActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        addConstraintToActivityIndicator()
    }
    
    func addConstraintToActivityIndicator() {
//        let height = self.activityIndicator.heightAnchor.constraint(equalToConstant: 100)
//        let width = self.activityIndicator.widthAnchor.constraint(equalToConstant: 100)
        let xCenter = self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let yCenter = self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        view.addConstraints([xCenter, yCenter])
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
        viewModel.getTableData()
        activityIndicator.startAnimating()
        refreshControl.endRefreshing()
    }
}

// MARK:- Binding
extension BaseViewController {
    func bind() {
        bindDataDidLoad()
    }
    
    func bindDataDidLoad() {
        viewModel.dataDidLoad.bind {[weak self] (didLoad) in
            self?.title = self?.viewModel.title
            self?.activityIndicator.stopAnimating()
            self?.tableview.reloadData()
        }
    }
}

extension BaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.baseTableViewCell.rawValue) as? BaseTableViewCell else { return UITableViewCell()
        }
        
        cell.configure(with: viewModel.cellViewModel(for: indexPath))
        return cell
    }
    
    
}

extension BaseViewController: UITableViewDelegate {
    
}

