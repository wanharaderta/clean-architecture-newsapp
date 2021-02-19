//
//  About.swift
//  NewsApp
//
//  Created by Wanhar on 17/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct AboutView: View {
  
  @ObservedObject var presenter: AboutPresenter
  
  @State var isEditing = false
  var body: some View {
    
    return ZStack {
      VStack {
        HStack {
          Text("About")
            .font(.largeTitle)
            .fontWeight(.bold)
          Spacer()
        }.padding()
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
          VStack(spacing: 0) {
            HStack {
              Spacer()
              WebImage(url: URL(string: PHOTO))
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .shadow(radius: 10)
              Spacer()
            }.padding(.top, 30)
            
            ZStack {
              VStack {
                VStack(alignment: .leading) {
                  Text("Nama").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                  HStack {
                    if isEditing {
                      TextField("Enter Your Name", text: self.$presenter.name)
                        .disabled(false)
                    } else {
                      TextField("Enter Your Name", text: self.$presenter.name)
                        .disabled(true)
                    }
                  }
                  Divider()
                }.padding(.bottom, 15)

                VStack(alignment: .leading) {
                  Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                  HStack {
                    if isEditing {
                      TextField("Enter Your Email", text: self.$presenter.email)
                        .disabled(false)
                    } else {
                      TextField("Enter Your Email", text: self.$presenter.email)
                        .disabled(true)
                    }

                  }

                  Divider()
                }.padding(.bottom, 15)

                Button(action: {
                  if isEditing {
                    self.presenter.setProfile()
                  } else {
                    self.presenter.getProfile()
                  }
                  self.isEditing.toggle()
                }) {
                  if isEditing {
                    Text("Save").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                  } else {
                    Text("Edit").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                  }
                }.background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
              }
              .padding()
              .background(CustomShape(corner: .allCorners, radii: 30).fill(Color.gray.opacity(0.1)))
            }
            .padding(.top, 30)
          }
          .padding()
        })
      }
    }.background(Color.white)
  }
}

