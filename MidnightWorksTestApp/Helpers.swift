//
//  Helpers.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 03.10.2021.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
