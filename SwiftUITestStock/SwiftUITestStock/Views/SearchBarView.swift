//
//  SearchBarView.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/29/20.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var onTextChanged: (String) -> Void

    class Coordinator: NSObject, UISearchBarDelegate {
        var onTextChanged: (String) -> Void
        @Binding var text: String
        

        init(text: Binding<String>, onTextChanged: @escaping (String) -> Void) {
            _text = text
            self.onTextChanged = onTextChanged
        }

        // Show cancel button when the user begins editing the search text
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            onTextChanged(text)
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            // Send back empty string text to search view, trigger self.model.searchResults.removeAll()
            onTextChanged(text)
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onTextChanged: onTextChanged)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search for a stock"
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.showsCancelButton = true
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputText = searchController.searchBar.text,
              inputText.count > 0 else { return }
        text = inputText
    }
}


/*
 
 HStack {
     HStack {
         Image(systemName: "magnifyingglass")
         
         SearchBar(text: $stockViewModel.query) { (_)var onTextChanged: (String) -> Void in
             loadSearchData()
         }
         
         
         
         /*
         TextField("Search for a Stock", text: $stockViewModel.query, onEditingChanged: { isEditing in
                     self.showCancelButton = true }, onCommit: loadSearchData)
             .foregroundColor(.primary)
*/
         Button(action: {
             self.stockViewModel.query = ""
         }) {
             Image(systemName: "xmark.circle.fill").opacity(stockViewModel.query == "" ? 0 : 1)
         }
     }
     .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
     .foregroundColor(.secondary)
     .background(Color(.secondarySystemBackground))
     .cornerRadius(10.0)

     if showCancelButton  {
         Button("Cancel") {
                 UIApplication.shared.endEditing(true) // this must be placed before the other commands here
             self.stockViewModel.query = ""
                 self.showCancelButton = false
         }
         .foregroundColor(Color(.systemBlue))
     }
 }
 .padding(.horizontal)
 .navigationBarHidden(showCancelButton)
     .animation(.default)
 .onAppear(perform: stockViewModel.fetchDataSource)
 */
