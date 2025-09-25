//
//  UserListInteractor.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import Foundation
/// Protocolo para el Interactor de la lista de usuarios
protocol UserListInteractorProtocol {
    /// Obtiene la lista de usuarios desde la API
    func fetchUsers()
}
/// Protocolo para la salida del Interactor
protocol UserListInteractorOutputProtocol: AnyObject {
    /// Notifica los usuarios obtenidos exitosamente
    /// - Parameter users: Lista de usuarios
    func didFetchUsers(_ users: [User])
    /// Notifica un error al obtener usuarios
    /// - Parameter error: Mensaje de error
    func didFailToFetchUsers(_ error: String)
}
/// Interactor que maneja la lógica de negocio para obtener usuarios
class UserListInteractor: UserListInteractorProtocol {
    /// Referencia débil al protocolo de salida
    weak var output: UserListInteractorOutputProtocol?
    /// Realiza la llamada a la API para obtener usuarios
    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            output?.didFailToFetchUsers("URL inválida")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.output?.didFailToFetchUsers("Error en la red: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self?.output?.didFailToFetchUsers("Respuesta inválida del servidor")
                return
            }
            guard let data = data else {
                self?.output?.didFailToFetchUsers("No se recibieron datos")
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.output?.didFetchUsers(users)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.output?.didFailToFetchUsers("Error al decodificar datos: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
