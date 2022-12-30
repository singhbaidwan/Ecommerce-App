//
//  SharedDataModel.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 05/11/22.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    @Published var detailProduct : Product?
    @Published var showDetailProduct : Bool = false
    
    @Published var fromSearchPage:Bool = false
    
    
    @Published var likedProducts:[Product] = []
    @Published var cartProducts:[Product] = []
    
}
