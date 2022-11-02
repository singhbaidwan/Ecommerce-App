//
//  StaggeredGrid.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 30/10/22.
//

import SwiftUI

struct StaggeredGrid<Content:View,T:Identifiable>: View where T:Hashable{
    // It will return each object from collection to build view
    
    var content:(T)->Content
    var list:[T]
    var showIndicators:Bool
    var spacing:CGFloat
    var columns:Int
    func setUpList()->[[T]]{
        var gridArray:[[T]] = Array(repeating: [], count: columns)
        var currentIndex = 0
        
        for object in list{
            
            gridArray[currentIndex].append(object)
            
            if currentIndex == (columns - 1)
            {
                currentIndex = 0
            }
            else
            {
                currentIndex+=1
            }
            
        }
        
        return gridArray
    }
    
    init(columns:Int,showIndicators:Bool = false,spacing:CGFloat=10,content: @escaping (T) -> Content, list: [T]) {
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showIndicators = showIndicators
        self.columns = columns
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: showIndicators)
        {
            HStack(alignment:.top,spacing: 20){
                
                ForEach(setUpList(),id:\.self){ columnData in
                    LazyVStack(spacing:spacing){
                        ForEach(columnData){ object in
                            content(object)
                        }
                    }
                    .padding(.top,getIndex(values: columnData) == 1 ? 80 : 0)
                }
                
            }
            .padding(.vertical)
        }
    }
    
    
    func getIndex(values:[T])->Int{
        
        let index = setUpList().firstIndex{ t in
            return t==values
        } ?? 0
        return index
    }
    
}
//
//struct StaggeredGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        StaggeredGrid()
//    }
//}
