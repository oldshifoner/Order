//
//  MainOrderRefusalContentView.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 15.12.2024.
//

import SwiftUI

@main
struct MainOrderRefusalContentView: App {
    @StateObject private var globalViewModel = CancellationViewModel()

    var body: some Scene {
        WindowGroup {
            OrderRefusalContentView()
                .environmentObject(globalViewModel)
        }
    }
}
