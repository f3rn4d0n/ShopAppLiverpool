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
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCellIdentifier")
        return tableView
    }()
    
    lazy var searchBar:UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchBarStyle = .minimal
        search.searchBar.placeholder = "Please write your product to search"
        search.searchBar.sizeToFit()
        search.searchBar.isTranslucent = false
        search.searchBar.delegate = self
//        search.searchResultsUpdater = self
        return search
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
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.8761232495, green: 0.002402308164, blue: 0.5914769173, alpha: 1)
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = "Liverpool"
        navigationItem.searchController = searchBar
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
        cell.fillWith(product: controller.products[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        controller.requestListProducts(category: searchBar.text ?? "")
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
