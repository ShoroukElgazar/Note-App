//
//  Repos.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/9/23.
//

import Foundation

public protocol ReposContract {
    var note: NoteRepo { get }
}

public struct Repos: ReposContract {
    public static let shared = Repos()
    public var note: NoteRepo = .shared
    
    public static func build() -> ReposContract {
        Repos.shared
    }

}
