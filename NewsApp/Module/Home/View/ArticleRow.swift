//
//  ArticleItem.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleRow: View {
  
  var item: ArticleModel
  var body: some View {
    HStack {
      WebImage(url: URL(string: item.urlToImage))
        .resizable()
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .cornerRadius(10)
        .scaleEffect()
        .frame(width: 110, height: 100)
      VStack {
        Text(item.title)
          .font(.system(size: 15))
          .bold()
          .lineLimit(1)
         
        Text(item.description)
          .font(.caption)
          .lineLimit(2)
          .padding(.top, 3)
          .foregroundColor(Color.gray.opacity(1))
        
        HStack {
          Text(item.author)
            .font(.caption)
            .foregroundColor(Color.blue)
            .padding(.top, 5)
          Spacer()
        }
      }.padding(.leading, 5)
    }.padding([.top, .bottom],5)
  }
}
