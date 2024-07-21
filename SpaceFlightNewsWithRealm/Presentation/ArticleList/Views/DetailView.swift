//
//  DetailView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: vm.article.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView("Loading Image")
                        .controlSize(.extraLarge)
                }
                .frame(maxWidth: .infinity, minHeight: 160, alignment: .center)
                VStack(alignment: .leading) {
                    Text(vm.article.title)
                        .font(.title)
                    HStack {
                        Text(vm.article.newsSite)
                            .bold()
                        Spacer()
                        Text(vm.article.publishedAt.convertToLongDateTimeFormat())
                    }
                    .font(.subheadline)
                    .padding(.bottom)
                    Text(vm.shortenedSummary)
                        .padding(.bottom)
                    Link(destination: URL(string: vm.article.url)!, label: {
                        HStack {
                            Spacer()
                            Label("Original Article", systemImage: "link")
                        }
                    })
                    
                }
                .padding()
                Spacer()
            }
            .padding()
        }

        
    }
}

#Preview {
    DetailView(vm: DetailViewModel(article: Article.preview))
}
