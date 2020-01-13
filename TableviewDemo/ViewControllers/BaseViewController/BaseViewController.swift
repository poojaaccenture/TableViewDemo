//
//  ViewController.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var tableview: UITableView?
    var viewModel = BaseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initialSetup()
        viewModel.getTableData()
    }

    func initialSetup() {
        self.view.backgroundColor = .white
        
        setTableView()
    }
    
    func setTableView()  {
        tableview = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 320, height: 480), style: .grouped)
    }

}

