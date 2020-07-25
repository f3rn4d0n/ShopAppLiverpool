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
    var delegate: SearchControllerProtocol?
    var products:[Product] = []
    let webServices = ProducstWebServices()
    
    func requestListProducts(category:String = "Zapatos") {
        webServices.delegate = self
        webServices.requestListProducts(category)
    }
}

extension SearchController: ProducstWebServicesDelegate{
    func errorServices(message: String) {
        self.delegate?.errorServices(message: message)
    }
    
    func newList(products: [Product]) {
        self.products = products
        self.delegate?.listProductsUpdated()
        if products.count == 0{
            self.delegate?.errorServices(message: "Nothing to show, try to find something else")
        }
    }
    
    func requestError(_ error: Error) {
        self.delegate?.errorServices(message: error.localizedDescription)
    }
}
