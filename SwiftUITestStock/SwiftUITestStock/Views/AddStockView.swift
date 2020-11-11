//
//  AddStockView.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/27/20.
//

import SwiftUI

protocol SelectStock {
    func didSelect(_ stock: String?)
}

struct AddStockView: View {
    
    var delegate: SelectStock?
    
    @ObservedObject var stockViewModel: StockViewModel
    
    @State private var showCancelButton: Bool = false
    
    
    var body: some View {
        VStack {
            // Search view
            SearchBar(text: $stockViewModel.query) { (_) in
                loadSearchData()
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)
                .animation(.default)
            //.onAppear(perform: stockViewModel.)
            
            List {
                ForEach(stockViewModel.dataSource) { info in
                    SearchRow(info: info)
                }
            }
            //.resignKeyboardOnDragGesture()
        }
        
        
    }
    
    func loadSearchData() {
        stockViewModel.fetchStock(with: stockViewModel.query)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}






struct AddStockView_Previews: PreviewProvider {
    static var previews: some View {
        AddStockView(stockViewModel: StockViewModel())
    }
}

/*
 private extension AddStockView {
 
 func loadPopularStocks() {
 let popularSymbols: [String] =
 [
 "APPL",
 "TSLA",
 "DIS",
 "GOOG",
 "MSFT",
 "SNAP",
 "UBER",
 "TWTR",
 "AMD",
 "FB",
 "LK",
 "AMAZ"
 
 ]
 
 self.stockViewModel.dataSource = popularSymbols.dataSource
 }
 
 }
 */


/*
 private extension Sequence where Iterator.Element == String {
 
 var dataSource: [AddSection] {
 var sections: [AddSection] = []
 
 let items = self.map { $0.item }
 let section = AddSection(header: "Popular Stocks", items: items)
 sections.append(section)
 
 return sections
 }
 }
 
 extension String {
 
 var item: AddItem {
 let a = MyStocks().symbols.contains(self)
 
 return AddItem(title: self, alreadyInList: a)
 }
 
 }
 */



struct AddSection: Identifiable, Codable {
    
    let id = UUID()
    var header: String?
    var items: [AddItem]?
    
}

struct AddItem: Identifiable, Codable {
    
    let id = UUID()
    var title: String?
    var subtitle: String?
    
    var alreadyInList: Bool
    
}

struct SearchRow: View {
    let info: AddSection
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(info.items ?? []) { item in
                Text(item.title ?? "Test")
                    .font(.headline)
                Text(item.subtitle ?? "Test")
                    .font(.subheadline)
                
            }
        }
    }
}
