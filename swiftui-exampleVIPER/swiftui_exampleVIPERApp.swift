//
//  swiftui_exampleVIPERApp.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//

import SwiftUI

struct swiftui_exampleVIPERApp: App {
    /// Adaptador para conectar el AppDelegate de UIKit
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    /// Escena principal de la aplicación
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
