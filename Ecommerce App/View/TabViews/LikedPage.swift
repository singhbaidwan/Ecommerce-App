//
//  LikedPage.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 06/11/22.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var homeData:HomeViewModel
    @EnvironmentObject var sharedData:SharedDataModel
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical,showsIndicators: false)
            {
                VStack{
                    HStack{
                        Text("Favourites")
                            .font(.custom(customFont, size: 28))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25,height: 25)
                        }

                    }
                    
                    if sharedData.likedProducts.isEmpty {
                        
                        Group{
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,35)
                            Text("No Favourites Yet")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Hit the like Button on each product page to save favourite one.")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                        }
                        
                    } else {
                        
                        VStack(spacing: 15) {
                            ForEach(homeData.products)
                            {
                                product in
                                HStack(spacing: 0) {
                                    CardView(product:product)
                                }
                            }
                        }
                        
                    }
                    
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color("BG").ignoresSafeArea()
            )
            
        }
        
    }
    
    @ViewBuilder
    func CardView(product:Product)->some View{
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100,height: 100)
        }
    }
    
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(HomeViewModel())
            .environmentObject(SharedDataModel())
    }
}
