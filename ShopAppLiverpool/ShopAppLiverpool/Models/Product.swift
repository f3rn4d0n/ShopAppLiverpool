//
//  Product.swift
//  ShopAppLiverpool
//
//  Created by Luis Fernando Bustos Ramírez on 25/07/20.
//  Copyright © 2020 com.gastandoTenis.ShopAppLiverpool. All rights reserved.
//

import UIKit


struct ProductWSResponse: Decodable{
    var status: status
    var plpResults: plpResults
}

struct status: Decodable{
    var status: String
    var statusCode: Int
}

struct plpResults: Decodable{
    var plpState: plpState
    var records: [Product]
}

struct plpState: Decodable{
    var firstRecNum: Int
    var lastRecNum: Int
    var recsPerPage: Int
    var totalNumRecs: Int
    var originalSearchTerm: String
}

struct Product: Decodable {
    var productDisplayName:String
    var listPrice:Double
    var smImage:String
    var seller:String
}
