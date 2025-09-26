//
//  UserListInteractor.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import Foundation
import CoreData
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
			fetchLocalUsers()
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.output?.didFailToFetchUsers("Error en la red: \(error.localizedDescription)")
				self?.fetchLocalUsers()
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self?.output?.didFailToFetchUsers("Respuesta inválida del servidor")
				self?.fetchLocalUsers()
                return
            }
            guard let data = data else {
                self?.output?.didFailToFetchUsers("No se recibieron datos")
				self?.fetchLocalUsers()
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
				self?.saveUsersToCoreData(users)
                DispatchQueue.main.async {
                    self?.output?.didFetchUsers(users)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.output?.didFailToFetchUsers("Error al decodificar datos: \(error.localizedDescription)")
					self?.fetchLocalUsers()
                }
            }
        }
        task.resume()
    }
	/// Guarda usuarios en Core Data
	/// - Parameter users: Lista de usuarios a guardar
	private func saveUsersToCoreData(_ users: [User]) {
		let context = CoreDataManager.shared.managedObjectContext
		context.perform {
			let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
			do {
				let existingEntities = try context.fetch(fetchRequest)
				existingEntities.forEach { context.delete($0) }
				users.forEach { user in
					_ = user.toEntity(in: context)
				}
				try context.save()
				print("UserListInteractor: Saved \(users.count) users to Core Data")
			} catch {
				print("UserListInteractor: Error saving to Core Data: \(error)")
			}
		}
	}
	/// Recupera usuarios desde Core Data
	private func fetchLocalUsers() {
		let context = CoreDataManager.shared.managedObjectContext
		context.perform {
			let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
			do {
				let entities = try context.fetch(fetchRequest)
				let users = entities.map { User.from(entity: $0) }
				DispatchQueue.main.async {
					if users.isEmpty {
						self.output?.didFailToFetchUsers("No se encontraron datos locales ni en la API")
					} else {
						self.output?.didFetchUsers(users)
						print("UserListInteractor: Fetched \(users.count) users from Core Data")
					}
				}
			} catch {
				DispatchQueue.main.async {
					self.output?.didFailToFetchUsers("Error al recuperar datos locales: \(error.localizedDescription)")
				}
			}
		}
	}
}
