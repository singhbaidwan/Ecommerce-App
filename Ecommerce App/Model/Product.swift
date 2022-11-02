//
//  Product.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 26/10/22.
//

import SwiftUI

struct Product:Identifiable,Hashable{
    var id = UUID().uuidString
    var type:ProductTypes
    var title:String
    var subtitle:String
    var description:String=""
    var price:String
    var productImage:String = ""
    var quanity:Int = 1
}

enum ProductTypes:String,CaseIterable
{
    case Wearable = "Wearable"
    case Laptops = "Laptops"
    case Phones = "Phones"
    case Tablets = "Tablets"
}
