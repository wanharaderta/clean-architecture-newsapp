//
//  AboutPresenter.swift
//  NewsApp
//
//  Created by Wanhar on 19/02/21.
//
import Core
import Foundation

class AboutPresenter:  ObservableObject {
  
  @Published var name: String = ""
  @Published var email: String = ""
  
  init() {
    getProfile()
  }
  
  func getProfile() {
    self.email = UserDefaults.standard.value(forKey: EMAIL) as? String ?? "Wanhardaengmaro@gmail.com"
    self.name = UserDefaults.standard.value(forKey: NAME) as? String ?? "Wanhar"
  }
  
  func setProfile() {
    UserDefaults.standard.set(self.name, forKey: NAME) 
    UserDefaults.standard.set(self.email, forKey: EMAIL)
  }
}
