//
//  SearchController.swift
//  ShopAppLiverpool
//
//  Created by Luis Fernando Bustos Ramírez on 25/07/20.
//  Copyright © 2020 com.gastandoTenis.ShopAppLiverpool. All rights reserved.
//

import UIKit
import Network


protocol SearchControllerProtocol{
    func errorServices(message:String)
    func listProductsUpdated()
}

class SearchController: NSObject {
    //Protocols
    var delegate: SearchControllerProtocol?
    
    //Managers
    private let webServices = ProducstWebServices()
    
    //Control variables
    private var productsWS:ProductWSResponse?
    private var products: [Product] = []
    private var categoryToSearch = ""
    private var pageToSearch = 1
    
    override init() {
        super.init()
        loadInformation()
    }
    
    func requestListProducts(category:String?) {
        webServices.delegate = self
        if let categorySelect = category{
            categoryToSearch = categorySelect
        }
        pageToSearch = 1
        webServices.requestListProducts(categoryToSearch, pageToSearch: "1")
    }
    
    func requestNextPage(){
        if pageToSearch <= 0 {
            pageToSearch = 1
        }
        if let lastRecNum = productsWS?.plpResults.plpState.lastRecNum, let totalNumRecs = productsWS?.plpResults.plpState.totalNumRecs{
            if lastRecNum < totalNumRecs{
                pageToSearch = pageToSearch + 1
                webServices.requestListProducts(categoryToSearch, pageToSearch: "\(pageToSearch)")
            }
        }
    }
    
    func getProducts() -> [Product]{
        return products
    }
    
    //User defaults
    private func storeInformation(){
        let defaults = UserDefaults.standard
        defaults.set(categoryToSearch, forKey: "categoryToSearch")
    }
    
    private func loadInformation(){
        let defaults = UserDefaults.standard
        categoryToSearch = defaults.string(forKey: "categoryToSearch") ?? ""
    }
}

extension SearchController: ProducstWebServicesDelegate{
    func errorServices(message: String) {
        self.delegate?.errorServices(message: message)
    }
    
    func requestComplete(productsWS: ProductWSResponse){
        if let originTerm = self.productsWS?.plpResults.plpState.originalSearchTerm{
            if originTerm == productsWS.plpResults.plpState.originalSearchTerm{
                self.products.append(contentsOf: productsWS.plpResults.records)
            }else{
                self.products = productsWS.plpResults.records
            }
        }else{
            self.products = productsWS.plpResults.records
        }
        self.productsWS = productsWS
        
        self.delegate?.listProductsUpdated()
        if getProducts().count == 0{
            self.delegate?.errorServices(message: "Nothing to show, try to find something else")
        }
    }
    
    func requestError(_ error: Error) {
        self.delegate?.errorServices(message: error.localizedDescription)
    }
}
