//
//  DetailView.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var presenter: DetailPresenter
  
  var body: some View {
    VStack {
      ZStack(alignment: .top) {
        ScrollView(.vertical, showsIndicators: false) {
          ZStack(alignment: .top) {
            WebImage(url: URL(string: self.presenter.article.urlToImage))
              .resizable()
              .frame(height: 320)
            HStack {
              Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "arrow.left")
                  .foregroundColor(.white)
                  .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 12)
                  .background(Color.black.opacity(0.3))
                  .clipShape(Circle())
              }
              .padding(.leading, 10)
              .padding(.top, 25)
              Spacer()
              if self.presenter.article.favorite {
                Button(action: { self.presenter.unFavorite() }) {
                  Image(systemName: "suit.heart.fill")
                    .foregroundColor(.red)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 12)
                    .background(Color.black.opacity(0.3))
                }.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .padding(.top, 40)
                .padding(.trailing, 10)
              } else {
                Button(action: { self.presenter.addfavorite() }) {
                  Image(systemName: "suit.heart")
                    .foregroundColor(.red)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 12)
                    .background(Color.black.opacity(0.3))
                }.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .padding(.top, 40)
                .padding(.trailing, 10)
              }
            }
          }.clipShape(CustomShape(corner: .bottomLeft, radii: 35))
          HStack {
            Text(self.presenter.article.title)
              .font(.title2)
              .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
          }.padding(.horizontal, 25)
          .padding(.top, 25)
          
          HStack {
            VStack(alignment: .leading) {
              HStack {
                Text("Description").font(.headline)
                Spacer()
              }
              Text("\(self.presenter.article.description) \(self.presenter.article.content)")
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .padding(.top, 10)
            }
          }.padding(.horizontal, 25)
          .padding(.top, 20)
          HStack {
            VStack {
              HStack {
                Text("Author").font(.headline)
                Spacer()
              }
              HStack {
                Text(self.presenter.article.author)
                  .foregroundColor(Color.blue)
                  .padding(.top, 10)
                Spacer()
              }
            }
          }.padding(.horizontal, 25)
          .padding(.top, 20)
          HStack {
            VStack {
              HStack {
                Text("Website").font(.headline)
                Spacer()
              }
              HStack {
                Text(self.presenter.article.sourceName)
                  .foregroundColor(Color.blue)
                  .padding(.top, 10)
                Spacer()
              }
            }
          }.padding(.horizontal, 25)
          .padding(.top, 20)
        }
      }
      Spacer()
    }.onAppear {
      self.presenter.getArticle()
    }
    .edgesIgnoringSafeArea(.all)
    .statusBar(hidden: true)
    .animation(.default)
    .navigationBarHidden(true)
  }
}
