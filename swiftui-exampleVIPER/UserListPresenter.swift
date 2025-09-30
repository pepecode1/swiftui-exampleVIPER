//
//  UserListPresenter.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
/// Protocolo para el Presenter de la lista de usuarios
protocol UserListPresenterProtocol {
    /// Notifica que la vista se ha cargado
    func viewDidLoad()
    /// Maneja la selección de un usuario
    /// - Parameter user: Usuario seleccionado
    func didSelectUser(_ user: User)
	/// Maneja la edición de un usuario
	/// - Parameter user: Usuario seleccionado
    func didEditUser(_ user: User)
}
/// Presenter que maneja la lógica de presentación para la lista de usuarios
class UserListPresenter: UserListPresenterProtocol {
	/// Referencia débil a la Vista
    weak var view: UserListViewProtocol?
    /// Referencia al Interactor
    var interactor: UserListInteractorProtocol?
    /// Referencia al Router
    var router: UserListRouterProtocol?
    /// Notifica al Interactor para obtener los usuarios
    func viewDidLoad() {
        interactor?.fetchUsers()
    }
    /// Notifica al Router para navegar a los detalles del usuario
    /// - Parameter user: Usuario seleccionado
    func didSelectUser(_ user: User) {
        router?.navigateToUserDetail(user: user)
	}
	/// Editar usuario.
	/// - Parameter user: usuario.
	func didEditUser(_ user: User) {
		router?.navigateToUserEdit(user: user)
	}
}
/// Implementación del protocolo para recibir datos del Interactor
extension UserListPresenter: UserListInteractorOutputProtocol {
    /// Maneja los usuarios obtenidos exitosamente
    /// - Parameter users: Lista de usuarios
    func didFetchUsers(_ users: [User]) {
        view?.displayUsers(users)
    }
    /// Maneja errores al obtener usuarios
    /// - Parameter error: Mensaje de error
    func didFailToFetchUsers(_ error: String) {
        view?.showError(error)
    }
}
