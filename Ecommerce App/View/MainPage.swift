//
//  MainPage.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 22/10/22.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab:Tab = .home
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.home)
                Text("Liked")
                    .tag(Tab.liked)
                ProfilePage()
                    .tag(Tab.profile)
                Text("Cart")
                    .tag(Tab.cart)
            }
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id: \.rawValue){ tab in
                    Button{
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22,height: 22)
                            .background(
                            Color("Purple")
                                .opacity(0.1)
                                .cornerRadius(5)
                                .blur(radius: 5)
                                .padding(-7)
                                .opacity(currentTab == tab ? 1 : 0)
                            
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom,10)
            
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
enum Tab:String,CaseIterable{
    case home = "house.fill"
    case liked = "heart"
    case profile = "person.crop.circle"
    case cart = "cart"
    
}
