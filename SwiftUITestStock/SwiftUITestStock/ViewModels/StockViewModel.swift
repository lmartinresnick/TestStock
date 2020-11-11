//
//  StockViewModel.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 11/10/20.
//

import SwiftUI

final class StockViewModel: ObservableObject {
    // Input
    // Output
    let provider: Provider = Provider.finnhub
    
    @Published var dataSource: [AddSection] = []
    @Published var searchResults: [AddSection] = []
    @Published var query: String = "" {
        didSet {
            fetchStock(with: query)
        }
    }
    
    static let apiKey = "bu4tt0f48v6sjdfq45gg"
    
    static let host = "finnhub.io"
    static let baseUrl = "/api/v1"
    
    static var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }
    
    
//    func fetchDataSource() {
//        print("hello")
//        provider.search("") { (allStocks) in
//            let section = AddSection(header: "Search", items: allStocks)
//            self.dataSource = [section]
//        }
//    }
    
    func fetchStock(with query: String) {
        print("load search with \(query)")
        provider.search(query) { (allStocks) in
            //var sections: [AddSection] = []
            let items =  [String()].map { $0.item }
            let section = AddSection(header: "Search", items: items)
            
            //sections.append(section)
            self.dataSource = [section]
        }
    }
    
    static func getSearchResults(_ query: String, completion: @escaping ([Finnhub.Symbol]?) -> Void) {
        print(query)
        let url = symbolUrl()
        url?.get { (results: [Finnhub.Symbol]?) in
            let lower = query.lowercased()
            print(lower)
            let filtered = results?.compactMap { $0 }.filter {
                $0.description.lowercased().contains(lower) || $0.symbol.lowercased().contains(lower) }
            completion(filtered)
            
            //completion(filtered)
        }
    }
    
    enum Endpoint: String {
        case companyNews, profile2, quote, symbol
        
        var path: String {
            switch self {
            case .companyNews:
                return "\(baseUrl)/company-news"
            case .quote:
                return "\(baseUrl)/\(self.rawValue)"
            case .profile2, .symbol:
                return "\(baseUrl)/stock/\(self.rawValue)"
            }
        }
    }
    
    static var baseUrlComponents: URLComponents {
        var c = URLComponents()
        c.scheme = "https"
        c.host = host
        
        return c
    }
    
    static var tokenQueryItem: URLQueryItem {
        let queryItem = URLQueryItem(name: "token", value: apiKey)
        return queryItem
    }
    
    static func url(path: String, queryItems: [URLQueryItem]) -> URL? {
        var c = baseUrlComponents
        c.path = path
        c.queryItems = queryItems
        
        let u = c.url
        
        return u
    }
    
    
    static func url(path: String, symbol: String?, numberOfDays: TimeInterval? = nil) -> URL? {
        guard let symbol = symbol else { return nil }
        
        let s = URLQueryItem(name: "symbol", value: symbol)
        
        guard let numberOfDays = numberOfDays else {
            let queryItems = [ tokenQueryItem, s]
            
            return url(path: path, queryItems: queryItems)
        }
        
        let fromDate = Date().addingTimeInterval(-numberOfDays * 24 * 60 * 60)
        let from = dateFormatter.string(from: fromDate)
        let fromQi = URLQueryItem(name: "from", value: from)
        
        let to = dateFormatter.string(from: Date())
        let toQi = URLQueryItem(name: "name", value: to)
        
        let queryItems = [tokenQueryItem, s, fromQi, toQi]
        
        return url(path: path, queryItems: queryItems)
    }
    
    
    static func newsUrl(_ symbol: String?) -> URL? {
        return url(path: Endpoint.companyNews.path, symbol: symbol, numberOfDays: 14)
    }
    static func profile2Url(_ symbol: String) -> URL? {
        return url(path: Endpoint.profile2.path, symbol: symbol)
    }
    static func quoteUrl(_ symbol: String) -> URL? {
        return url(path: Endpoint.quote.path, symbol: symbol)
    }
    static func symbolUrl(_ exchange: String = "US") -> URL? {
        var c = baseUrlComponents
        c.path = Endpoint.symbol.path
        
        let exchangeQi = URLQueryItem(name: "exchange", value: exchange)
        c.queryItems = [exchangeQi,tokenQueryItem]
        
        let u = c.url
        return u
    }
}

private extension String {
    
    var item: AddItem {
        let a = MyStocks().symbols.contains(self)
        
        return AddItem(title: self, alreadyInList: a)
    }
}







/*
 // Functional Reactive Programming
 final class StockViewModelAlternative: ObservableObject {
 // Input
 // Output
 let service: FinnhubService = FinnhubService()
 
 var bag: Set<AnyCancellable> = Set<AnyCancellable>()
 
 // this acts as an Input
 @Published var query: String = ""
 
 @Published var dataSource: [Finnhub] = []
 
 // this acts as the output
 @Published var searchResults: [Finnhub] = []
 
 init(service: FinnhubService) {
 self.service = service
 
 // When we append a $ symbol in front, we convert it into a Publisher type.
 $query
 .map { newQuery in
 return dataSource.filter {
 $0.description == newQuery
 }
 }
 .assign(\.searchResults)
 .store(in: &bag)
 
 }
 
 }
 
 struct AllStocksView: View {
 // @ObservedObject
 @StateObject var stockViewModel: StockViewModel = StockViewModel()
 
 var body: some View {
 List(stockViewModel.dataSource) { singleStock in
 StockViewDetail(singleStock)
 }
 Button(action: stockViewModel.fetchDataSource()) {
 Text("Refresh")
 }
 }
 
 }
 
 
 struct SearchStockView: View {
 
 @StateObject var stockViewModel: StockViewModel = StockViewModel()
 
 var body: some View {
 
 // TextField()
 List(stockViewModel.searchResults) { singleStock in
 StockViewDetail(singleStock)
 }
 
 }
 
 }
 */
