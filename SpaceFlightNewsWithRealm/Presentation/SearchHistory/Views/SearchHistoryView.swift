//
//  SearchHistoryView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI
import RealmSwift

struct SearchHistoryView: View {
    @StateObject var vm = SearchHistoryViewModel()
//    @Environment(\.managedObjectContext) var moc
    @ObservedResults(SearchHistoryObject.self) var searchHistories
    
    
    var body: some View {
        VStack {
            if vm.searchHistories.isEmpty {
                ContentUnavailableView("There is no Search History yet", systemImage: "exclamationmark.arrow.circlepath")
            } else {
                List {
                    ForEach(searchHistories, id:\.self) { searchHistory in
                        Text(searchHistory.searchText)
//                        DisclosureGroup {
//                            if searchHistory.articles.isEmpty {
//                                ContentUnavailableView("No Article for this Search History", systemImage: "point.bottomleft.forward.to.point.topright.scurvepath")
//                            }
//                            else {
//                                ForEach(searchHistory.articles, id:\.self) { article in
//                                    Button {
//                                        vm.toggleSheet(article: article)
//                                    } label: {
//                                        Text(article.title)
//                                            .font(.callout)
//                                    }
//                                    .buttonStyle(PlainButtonStyle())
//                                }
//                                .deleteDisabled(true)
//                            }
//                        } label: {
//                            Text(searchHistory.searchText)
//                        }
                    }
                    .onDelete(perform: $searchHistories.remove)
                }
                .sheet(isPresented: $vm.sheetIsPresented, content: {
                    DetailView(vm: DetailViewModel(article: vm.selectedArticle))
                })
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: vm.searchHistories)
                .alert("Delete all Search History", isPresented: $vm.alertIsPresented) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete All", role: .destructive) {
                        let realm = try! Realm()
                        try! realm.write {
                            realm.deleteAll()
                        }
                    }
                } message: {
                    Text("Are you sure you want to delete all search history?")
                }

            }
        }
        .navigationTitle("Search History")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.alertIsPresented.toggle()
                }, label: {
                    Image(systemName: "trash")
                })
                .tint(.red)
            }
        }
        .task {
            vm.loadSearchHistory()
        }
    }
}

#Preview {
    SearchHistoryView()
}
