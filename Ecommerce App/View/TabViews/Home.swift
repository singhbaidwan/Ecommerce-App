//
//  Home.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 26/10/22.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @StateObject var homeData:HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical,showsIndicators: false)
        {
            VStack(spacing: 15) {
                //                MARK: Search Bar
                ZStack{
                    if homeData.searchActivated {
                        SearchBar()
                    }
                    else
                    {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                    
                }
                .frame(width: getRect().width/1.6)
                .padding(.horizontal,25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut)
                    {
                        homeData.searchActivated = true
                    }
                }
                
                
                Text("Order Online\nCollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductTypes.allCases,id: \.rawValue)
                        {
                            type in
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,28)
                ScrollView(.horizontal,showsIndicators: false)
                {
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts){
                            product in
                            // Product Card View
                            
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top,80)
                }
                .padding(.top,30)
                
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color("Purple"))
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
                .padding(.top,10)

                
            }
            .padding(.vertical)
        }
        .background(
            Color("BG")
                .opacity(0.2)
        )
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .onChange(of: homeData.productType) { _ in
            homeData.filterByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductView()
        }
        .overlay {
            
            if homeData.searchActivated {
                
                SearchView(animation: animation)
                    .environmentObject(homeData)
                    
                
            }
        }

    }
    
    
    @ViewBuilder
    func SearchBar()->some View{
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Search",text: .constant(""))
                .disabled(true)
            
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray,lineWidth: 0.8)
            
        )
        
        
    }
    
    
    @ViewBuilder
    func ProductCardView(product:Product)->some View{
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width/2.5,height: getRect().width/2.5)
                .offset(y:-80)
                .padding(.bottom,-80)
            
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
        .padding(.top,80)
    }
    
    @ViewBuilder
     func ProductTypeView(type:ProductTypes)->some View{
        Button{
            homeData.productType = type
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("Purple") : Color.gray)
                .padding(.bottom,10)
                .overlay {
                    ZStack(alignment:.bottom) {
                        if homeData.productType == type{
                            Capsule()
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                            
                        }
                        else
                        {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                        
                    }
                    .padding(.horizontal,5)
                    .padding(.top,10)
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
