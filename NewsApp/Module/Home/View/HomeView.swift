//
//  HomeView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var presenter: HomePresenter
  @State var articleSelected : ArticleModel? = nil
  @State var showingDetail = false
  @State var querySearch = ""
  
  var body: some View {
    VStack {
      HStack {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
          Image("filter")
            .resizable()
            .renderingMode(.original)
            .frame(width: 24, height: 24)
        })
        
        Spacer(minLength: 0)
        Text("17 Februari,2021")
          .font(.body)
          .foregroundColor(.gray)
      }.padding()
      
      ScrollView(.vertical, showsIndicators: false, content: {
        VStack {
          Text("Browse News")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 30)
          
          HStack(spacing: 15, content: {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
            TextField("Search for topics, sources", text: $querySearch)
          })
          .padding(10)
          .padding(.horizontal)
          .background(Color.white)
          .clipShape(Capsule())
          
          ZStack {
            VStack {
              if presenter.isLoading {
                VStack {
                  Text("Loading...")
                  ActivityIndicator()
                  
                }
              } else {
                ForEach(self.presenter.articles, id: \.id) { article in
                  ArticleRow(item: article).onTapGesture {
                    self.articleSelected = article
                    self.showingDetail.toggle()
                    print("wwww,\(articleSelected)")
                  }
                }
              }
            }
            .padding(.top, 15)
          }.onAppear {
            if self.presenter.articles.count == 0 {
              self.presenter.getArticles()
            }
          }
        }.padding()
      })
    }
//    .sheet(isPresented: $showingDetail, content: {
//      self.presenter.linkBuilder(for: articleSelected, content: Content)
//    })
  }
  
}
