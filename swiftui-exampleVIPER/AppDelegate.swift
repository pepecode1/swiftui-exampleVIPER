//
//  AppDelegate.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import Foundation
import UIKit
/// Clase que gestiona el ciclo de vida de la aplicación UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Ventana principal de la aplicación
    var window: UIWindow?
    /// Configura la aplicación al terminar de lanzarse
    /// - Parameters:
    ///   - application: Instancia de la aplicación
    ///   - launchOptions: Opciones de lanzamiento
    /// - Returns: Verdadero si la configuración es exitosa
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let userListVC = UserListRouter.createUserListModule()
        let navigationController = UINavigationController(rootViewController: userListVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
