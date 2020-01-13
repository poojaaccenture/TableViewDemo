//
//  ViewController.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var tableview: UITableView!
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
    }
    
    func setTableView()  {
        tableview = UITableView()
        tableview.register(BaseTableViewCell.self, forCellReuseIdentifier: CellIdentifier.baseTableViewCell.rawValue)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
        self.view.addSubview(tableview!)
        addConstraintToTableView()
    }
    
    func addConstraintToTableView() {
       
     tableview?.translatesAutoresizingMaskIntoConstraints = false
        
      let leading =  self.tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
      let top =  self.tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
      let trailing =  self.tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
      let bottom =  self.tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        view.addConstraints([leading, top, trailing, bottom])
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

