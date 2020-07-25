//
//  SearchViewController.swift
//  ShopAppLiverpool
//
//  Created by Luis Fernando Bustos Ramírez on 25/07/20.
//  Copyright © 2020 com.gastandoTenis.ShopAppLiverpool. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //UIComponents
    lazy var productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCellIdentifier")
        return tableView
    }()
    
    //Workflow variables
    let controller = SearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestInfo()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        setupTableView()
    }
    
    func setupTableView(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(productsTableView)
        productsTableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        productsTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        productsTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        productsTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    }
    
    func requestInfo(){
        controller.delegate = self
        controller.requestListProducts()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.controller.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCellIdentifier", for: indexPath) as! ProductTableViewCell
        cell.setupUI()
        return cell
    }
}

extension SearchViewController: SearchControllerProtocol{
    func errorServices(message: String) {
        print(message)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let latter = UIAlertAction(title: "Accept", style: .default) { (_) in}
        alert.addAction(latter)
        present(alert, animated: true, completion: nil)
    }
    
    func listProductsUpdated(){
        productsTableView.reloadData()
    }
}
