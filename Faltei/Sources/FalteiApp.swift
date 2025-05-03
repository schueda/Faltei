//
//  FalteiApp.swift
//  Faltei
//
//  Created by André Schueda on 23/08/23.
//

import SwiftUI

@main
struct FalteiApp: App {
    @State private var selected: Int = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selected) {
                HistoricoView()
                    .tabItem {
                        Label("Histórico", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(0)
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "building.columns.fill")
                    }
                    .tag(1)
                ConfiguracoesView()
                    .tabItem {
                        Label("Configurações", systemImage: "gear")
                    }
                    .tag(2)
            }
        }
    }
}
