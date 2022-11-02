//
//  ContentView.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 21/10/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var log_status : Bool = false
    
    var body: some View {
        if log_status{
            MainPage()
        }
        else
        {
            OnBoardingPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
