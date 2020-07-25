//
//  SearchViewController.swift
//  ShopAppLiverpool
//
//  Created by Luis Fernando Bustos Ramírez on 25/07/20.
//  Copyright © 2020 com.gastandoTenis.ShopAppLiverpool. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCellIdentifier", for: indexPath) as! ProductTableViewCell
        return cell
    }
}
