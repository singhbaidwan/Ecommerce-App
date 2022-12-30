//
//  SearchView.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 30/10/22.
//

import SwiftUI

struct SearchView: View {
    var animation:Namespace.ID
    @EnvironmentObject var homeData:HomeViewModel
    @EnvironmentObject var sharedData:SharedDataModel
    
    @FocusState var startTF:Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(spacing: 20) {
                Button {
                    
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                }
                
                // Search Bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search",text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                    
                    
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("Purple"),lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
                
                
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    
                    VStack(spacing: 10) {
                        //                        Image("NotFound")
                        //                            .resizable()
                        //                            .aspectRatio(contentMode: .fit)
                        //                           .padding(.top,60)
                        Text("Item Not found")
                            .font(.custom(customFont, size: 22).bold())
                        Text("Try more generic search term or try looking for alternative products")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)
                        
                    }
                }
                else
                {
                    ScrollView(.vertical,showsIndicators: false){
                        
                        VStack(spacing: 0) {
                            
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            StaggeredGrid(columns: 2, spacing: 20,content: { product in
                                
                                ProductCardView(product: product)
                                
                            }, list: products)
                            
                        }
                        .padding()
                    }
                }
                
            }
            else
            {
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(
            Color("BG")
                .ignoresSafeArea()
            
        )
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1)
            {
                startTF = true
            }
        }
    }
    
    
    @ViewBuilder
    func ProductCardView(product:Product)->some View{
        VStack(spacing: 10) {
            ZStack{
                
                if sharedData.showDetailProduct {
                    
                        Image(product.productImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0)
                }
                else
                {
                    
                        Image(product.productImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
                
            }
                .offset(y:-50)
                .padding(.bottom,-50)
            
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top,50)
        .onTapGesture {
            withAnimation(.easeInOut)
            {
                sharedData.showDetailProduct = true
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
            }
        }
        
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
