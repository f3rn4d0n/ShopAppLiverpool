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
    func listUpdated(products: [Product])
}

class SearchController: NSObject {
    var delegate: SearchControllerProtocol?
    
    func requestListProducts() {
        let webServices = ProducstWebServices()
        webServices.delegate = self
        webServices.requestListProducts()
    }
}

extension SearchController: ProducstWebServicesDelegate{
    func errorServices(message: String) {
        self.delegate?.errorServices(message: message)
    }
    
    func newList(products: [Product]) {
        self.delegate?.listUpdated(products: products)
    }
    
    func requestError(_ error: Error) {
        self.delegate?.errorServices(message: error.localizedDescription)
    }
    
    
}
