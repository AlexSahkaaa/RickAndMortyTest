//
//  Ext+View.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 04.10.2021.
//

import SwiftUI

extension View {
    func navigationBackButton(color: UIColor, text: String? = nil) -> some View {
        modifier(NavigationBackButton(color: color, text: text))
    }
}
