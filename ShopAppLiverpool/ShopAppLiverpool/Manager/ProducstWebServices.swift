//
//  ProducstWebServices.swift
//  ShopAppLiverpool
//
//  Created by Luis Fernando Bustos Ramírez on 25/07/20.
//  Copyright © 2020 com.gastandoTenis.ShopAppLiverpool. All rights reserved.
//

import UIKit
import Network


protocol ProducstWebServicesDelegate{
    func errorServices(message:String)
    func newList(products: [Product])
    func requestError(_ error:Error)
}

class ProducstWebServices: NSObject {
    var delegate: ProducstWebServicesDelegate?
    var dataTask: URLSessionDataTask?
    let monitor = NWPathMonitor()
    var internetEnable = true
    
    func requestListProducts(_ search:String) {
        self.checkInternetConnection()
        if !internetEnable{
            self.delegate?.errorServices(message: "Internet connection is not enable, please try again latter" )
            return
        }
        
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp") {
            urlComponents.queryItems = [
                URLQueryItem(name: "force-plp", value: "true"),
                URLQueryItem(name: "search-string", value: search),
                URLQueryItem(name: "page-number", value: "3"),
                URLQueryItem(name: "number-of-items-per-page", value: "20")
            ]
            guard let url = urlComponents.url else {
                return
            }
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 15.0
            sessionConfig.timeoutIntervalForResource = 15.0
            let session = URLSession(configuration: sessionConfig)
            dataTask = session.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                DispatchQueue.main.async {
                    if let error = error {
                        self?.delegate?.requestError(error)
                    } else if let data = data, let response = response as? HTTPURLResponse{
                        do{
                            if response.statusCode == 200{
                                let productsWS = try JSONDecoder().decode(ProductWSResponse.self, from: data)
                                if productsWS.status.statusCode == 0{
                                    self?.delegate?.newList(products: productsWS.plpResults.records)
                                }else{
                                    self?.delegate?.errorServices(message: "Something went wrong, please try more latter")
                                }
                            }else{
                                self?.delegate?.errorServices(message: "Something went wrong, please try more latter")
                            }
                        } catch let error{
                            self?.delegate?.requestError(error)
                        }
                    }
                }
            }
            dataTask?.resume()
        }
    }
    
    func checkInternetConnection(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
