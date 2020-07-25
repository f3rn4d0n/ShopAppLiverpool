//
//  ProductTableViewCell.swift
//  ShopAppLiverpool
//
//  Created by Luis Fernando Bustos Ramírez on 25/07/20.
//  Copyright © 2020 com.gastandoTenis.ShopAppLiverpool. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    let thumbnail: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.layoutIfNeeded()
        image.backgroundColor = .blue
        return image
    }()
    
    let name:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    let price:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = label.font.withSize(14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let location:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = label.font.withSize(14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .gray
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(){
        self.backgroundColor = .clear
        self.addSubview(thumbnail)
        self.addSubview(name)
        self.addSubview(price)
        self.addSubview(location)
        
        thumbnail.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        thumbnail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor, multiplier: 1).isActive = true
        
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        name.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        price.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        price.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20).isActive = true
        price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        price.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        location.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 5).isActive = true
        location.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        location.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20).isActive = true
        location.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillWith(product:Product?){
        name.text = product?.productDisplayName
        price.text = "\(product?.listPrice ?? 0.0)"
        location.text = product?.seller
    }
}
