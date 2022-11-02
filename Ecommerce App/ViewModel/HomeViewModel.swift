//
//  HomeViewModel.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 26/10/22.
//

import SwiftUI

// using combine to monitor search field and if user leaves for 5 sec then start searching to avoid memory issue
import Combine

class HomeViewModel:ObservableObject{
    @Published var productType:ProductTypes = .Wearable
    @Published var products:[Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 8", price: "$350",productImage: "AppleWatch8"),
        Product(type: .Wearable, title: "Samsung Watch", subtitle: "Gear: Black", price: "$180",productImage: "SamsungWatch"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "SE", price: "$250",productImage: "AppleWatchSE"),
        Product(type: .Phones, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699",productImage: "iPhone13"),
        Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599",productImage: "iPhone12"),
        Product(type: .Phones, title: "iPhone 11", subtitle: "A13 - Purple", price: "$499",productImage: "iPhone11"),
        Product(type: .Phones, title: "iPhone SE 2", subtitle: "A13 - White", price: "$399",productImage: "iPhoneSE"),
        Product(type: .Laptops, title: "MacBooks Air", subtitle: "M1 - Gold", price: "$999",productImage: "MacBookAir"),
        Product(type: .Laptops, title: "MacBook Pro", subtitle: "M1 - Space Gray", price: "$1299",productImage: "MacBookPro"),
        Product(type: .Tablets, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999",productImage: "iPadPro"),
        Product(type: .Tablets, title: "iPad Air 4", subtitle: "A14 - Pink", price: "$699",productImage: "iPadAir"),
        Product(type: .Tablets, title: "iPad Mini", subtitle: "A15 - Gray", price: "$599",productImage: "iPadMini"),
        Product(type: .Laptops, title: "iMac", subtitle: "M1 - Purple", price: "$1599",productImage: "iMac")
    ]
    
    @Published var filteredProducts:[Product] = []
    @Published var showMoreProductsOnType:Bool = false
    @Published var searchText:String = ""
    @Published var searchActivated:Bool = false
    @Published var searchedProducts:[Product]?
    
    var searchCallable:AnyCancellable?
    
    init()
    {
        filterByType()
        searchCallable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterBySearch()
                }
                else
                {
                    self.searchedProducts = nil
                }
            })
    }
    func filterByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let result = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = result.compactMap({ product in
                    return product
                })
            }
        }
    }
    func filterBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let result = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            DispatchQueue.main.async {
                self.searchedProducts = result.compactMap({ product in
                    return product
                })
            }
        }
    }
    
}
