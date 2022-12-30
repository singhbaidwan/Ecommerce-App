//
//  ProductDetailView.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 05/11/22.
//

import SwiftUI

struct ProductDetailView: View {
    var product : Product
    var animation : Namespace.ID
    @EnvironmentObject var sharedData:SharedDataModel
    @EnvironmentObject var homeData:HomeViewModel
    var body: some View {
        
        VStack{
            
            VStack{
                
                HStack{
                    Button {
                        withAnimation(.easeInOut)
                        {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                    }
                    Spacer()
                    Button {
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22,height: 22)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                    }

                }
                .padding()
                
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y:-12)
                    .frame(maxWidth: .infinity)
                
                
            }
            .frame(height:getRect().height/2.7)
            .zIndex(1)
            
            
            ScrollView(.vertical,showsIndicators: false)
            {
                
                VStack(alignment:.leading,spacing: 1)
                {
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TV+ Free for year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone,iPad,iPod Touch,Mac or Apple TV, Rs. 10,000/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        
                        // since we need image at the right
                        Label {
                            Image(systemName: "arrow.right")
                            
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("Purple"))

                    }
                    HStack{
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        Spacer()
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Purple"))
                        
                    }
                    .padding(.vertical,20)
                    
                    Button {
                        addToCart()
                    } label: {
                        Text("Add to basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5,x: 5,y: 5)
                            )
                    }

                
                }
                .padding([.horizontal,.bottom],25)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color("BG").ignoresSafeArea())
        
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            sharedData.likedProducts.remove(at: index)
        }
        else
        {
            sharedData.likedProducts.append(product)
        }
        
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            sharedData.cartProducts.remove(at: index)
        }
        else
        {
            sharedData.cartProducts.append(product)
        }

    }
    
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        
        MainPage()
    }
}
