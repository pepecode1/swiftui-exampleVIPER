//
//  UserListRouter.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import UIKit
import SwiftUI
/// Protocolo para el Router de la lista de usuarios
protocol UserListRouterProtocol {
    /// Crea el módulo de la lista de usuarios
    static func createUserListModule() -> UIViewController
    /// Navega a la pantalla de detalles del usuario
    /// - Parameter user: Usuario seleccionado
    func navigateToUserDetail(user: User)
}
/// Router que maneja la creación del módulo y la navegación
class UserListRouter: UserListRouterProtocol {
    /// Referencia débil al controlador de la vista
    weak var viewController: UIViewController?
    /// Crea y configura el módulo VIPER para la lista de usuarios
    static func createUserListModule() -> UIViewController {
        let view = UserListVC()
        let presenter = UserListPresenter()
        let interactor = UserListInteractor()
        let router = UserListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        return view
    }
    /// Navega a la pantalla de detalles en SwiftUI
    /// - Parameter user: Usuario seleccionado
    func navigateToUserDetail(user: User) {
        let detailView = UserDetailView(user: user)
        let hostingController = UIHostingController(rootView: detailView)
        viewController?.navigationController?.pushViewController(hostingController, animated: true)
    }
}
