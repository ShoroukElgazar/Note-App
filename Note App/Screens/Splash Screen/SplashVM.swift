//
//  SplashVM.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/11/23.
//

import Foundation

class SplashVM: ObservableObject{
    public var repos: ReposContract

    public init(repos: ReposContract) {
        self.repos = repos
    }
  
}
