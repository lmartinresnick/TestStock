//
//  GridPinnedView.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/29/20.
//

import SwiftUI

struct GridPinnedView: View {
    
    fileprivate var stock_Data : [Placeholder]
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            LazyVGrid(columns: columns, spacing: 30) {
                
                ForEach(stock_Data) { stockData in
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text(stockData.symbol)
                                .foregroundColor(.white)
                            
                            Text("\(stockData.price)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                            
                            HStack {
                                
                                Spacer(minLength: 0)
                                
                                Text("\(stockData.change)")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        // image name same as color name
                        .background(Color(stockData.image))
                        .cornerRadius(20)
                        // shadow ...
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        
                        // top image ...
                        
                        Image(systemName: "arrow.up")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.12))
                            .clipShape(Circle())
                    }
                }
            }

            .padding(.horizontal)
            .padding(.top, 25)
        }
    }
}

struct GridPinnedView_Previews: PreviewProvider {
    static var previews: some View {
        GridPinnedView(stock_Data: placeholderList)
    }
}
