//
//  DetailView.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/27/20.
//

import SwiftUI

struct DetailView: View {
    
    var item: Item? {
        didSet {
            navigationTitle((item?.symbol)!)
            fetchData(item?.symbol)
        }
    }
    
    var provider: Provider?
    
    @State private var dataSource: [DetailSection] = []
    
    private let tableview = UITableView(frame: .zero, style: .insetGrouped)
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    var body: some View {
        List {
            ForEach(dataSource) { section in
                Section(header: Text(section.header ?? "Header")) {
                    SectionRow(info: section)
                }
                
                
            }
        }
        
    }
    
    
}

private extension DetailView {
    
    func fetchData(_ symbol: String?) {
        
        spinner.startAnimating()
        
        let priceItems = item?.items
        
        provider?.getDetail(symbol, completion: { (sections, image) in
            self.spinner.stopAnimating()
            
            if let image = image {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                
                var frame = imageView.frame
                frame.size = image.size
                imageView.frame = frame
                
                self.tableview.tableHeaderView = imageView
            }
            
            var s = sections
            let priceSection = DetailSection(id: UUID(), items: priceItems)
            let index = s.count > 1 ? 1 : 0
            s.insert(priceSection, at: index)
            
            
            self.tableview.reloadData()
            
        })
    }
    
//    func setup() {
//        
//        background(Color(.systemBackground))
//        
//        let button = Theme.closeButton
//        button.target = self
//        button.action = #selector(close)
//        NavigationBarItem.Type = button
//        
//        
//        
//    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct DetailSection: Identifiable, Codable {
    var id: UUID
    var header: String?
    var items: [DetailItem]?

}

struct DetailItem: Identifiable, Codable {

    var id: UUID
    var subtitle: String?
    var title: String?
    var url: URL?

}

struct SectionRow: View {
    let info : DetailSection
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(info.items ?? []) { item in
                Text(item.title ?? "Test")
                    .font(.headline)
                Text(item.subtitle ?? "Test")
                    .font(.subheadline)
                Text("\(item.url!)")
                    .font(.subheadline)
            }
        }
        
    }
}

private extension Item {
    
    var items: [DetailItem] {
        var items: [DetailItem] = []
        
        items.append(DetailItem(id: UUID(), subtitle: "Price", title: quote?.price.currency))
        
        items.append(DetailItem(id: UUID(), subtitle: "Change", title: quote?.change.displaySign))
        
        items.append(DetailItem(id: UUID(), subtitle: "Percent Change", title: quote?.percent.displaySign))
        
        return items
    }
}
