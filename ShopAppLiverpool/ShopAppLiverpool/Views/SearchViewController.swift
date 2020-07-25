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
        return search
    }()
    
    lazy var loaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.8
        view.isHidden = true
        return view
    }()
    
    let loaderTextLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Wait a moment please"
        return label
    }()
    
    let loaderIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .white
        return indicatorView
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
        setupLoader()
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
    
    func setupLoader(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(loaderView)
        loaderView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        loaderView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        loaderView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        loaderView.addSubview(loaderTextLabel)
        loaderTextLabel.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor, constant: -40).isActive = true
        loaderTextLabel.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        loaderTextLabel.widthAnchor.constraint(equalTo: loaderView.widthAnchor).isActive = true
        
        loaderView.addSubview(loaderIndicator)
        loaderIndicator.topAnchor.constraint(equalTo: loaderTextLabel.bottomAnchor, constant: 20).isActive = true
        loaderIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
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
        showLoader()
        controller.delegate = self
        controller.requestListProducts(category: nil)
    }
    
    func showLoader(){
        loaderView.isHidden = false
        loaderIndicator.startAnimating()
    }
    
    func closeLoader(){
        loaderView.isHidden = true
        loaderIndicator.stopAnimating()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.controller.getProducts().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCellIdentifier", for: indexPath) as! ProductTableViewCell
        cell.setupUI()
        cell.fillWith(product: controller.getProducts()[indexPath.row])
        let count = self.controller.getProducts().count
        if count > 1, indexPath.row == count - 1{
            self.controller.requestNextPage()
        }
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoader()
        controller.requestListProducts(category: searchBar.text)
    }
}

extension SearchViewController: SearchControllerProtocol{
    func errorServices(message: String) {
        closeLoader()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let latter = UIAlertAction(title: "Accept", style: .default) { (_) in}
        alert.addAction(latter)
        present(alert, animated: true, completion: nil)
    }
    
    func listProductsUpdated(){
        closeLoader()
        productsTableView.reloadData()
    }
}
