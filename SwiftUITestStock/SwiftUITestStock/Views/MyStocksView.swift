//
//  ContentView.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/21/20.
//

import SwiftUI

let navColor = UINavigationBarAppearance()

struct MyStocksView: View {
    
    @State var index = 0
    @StateObject var stockViewModel = StockViewModel()
    
    
    /*
    init() {
        navColor.configureWithOpaqueBackground()
        navColor.backgroundColor = .black
        navColor.titleTextAttributes = [.foregroundColor: UIColor.white]
        navColor.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = navColor
        UINavigationBar.appearance().scrollEdgeAppearance = navColor
    } */
 
    var body: some View {
        VStack {
            
            HStack {
                Text("Stocks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color"))
                
                Spacer(minLength: 0)
                Button(action: {
                    // Link to AddStockView
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color("Color"))
                        .clipShape(Circle())
                        
                }
                
            }.padding(.horizontal)
            
            // Tab View...
            
            HStack(spacing: 0) {
                Text("Pinned")
                    .foregroundColor(self.index == 0 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("Color").opacity(self.index == 0 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        
                        withAnimation(.default) {
                            self.index = 0
                        }
                        
                    }
                
                Spacer(minLength: 0)
                
                Text("All")
                    .foregroundColor(self.index == 1 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("Color").opacity(self.index == 1 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        
                        withAnimation(.default) {
                            self.index = 1
                        }
                        
                    }
                
                Spacer(minLength: 0)
                
                Text("Popular")
                    .foregroundColor(self.index == 2 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("Color").opacity(self.index == 2 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {

                        withAnimation(.default) {
                            self.index = 2
                        }

                    }
            }
            .background(Color.black.opacity(0.06))
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Dashboard Grid....
            
            // Tab View with swipe gestures
            // connecting index with tabview for tab change
            
            TabView(selection: self.$index) {
                
                // pinned data
                GridViewPinned(stock_Data: placeholderList).tag(0)
                
                // all data -> change to list view
                GridViewPinned(stock_Data: placeholderList).tag(1)
                
                // popular with search bar
                //SearchBar(text: .constant("")).tag(2)
                  //  .padding(.horizontal)
                
                AddStockView(stockViewModel: stockViewModel).tag(2)
                
                
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer(minLength: 0)
                
        }
        .padding(.top)
        
    }
    
    
}

struct GridViewPinned : View {
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MyStocksView()
    }
}




struct MyStocks {

    var symbols: [String] {
        return list.compactMap { $0.symbol }
    }

    fileprivate var dataSource: [Section] {
        var sections: [Section] = []

        let section = Section(items: list)
        sections.append(section)

        return sections
    }

    fileprivate func load() -> [Item] {
        return list
    }

    fileprivate mutating func save(_ items: [Item]) {
        self.list = items
    }

    private var list: [Item] = UserDefaultsConfig.list {
        didSet {
            UserDefaultsConfig.list = list
        }
    }

}

private struct UserDefaultsConfig {

    @UserDefault("list", defaultValue: [])
    fileprivate static var list: [Item]

}

private struct Section {
    
    var header: String?
    var items: [Item]?

}


