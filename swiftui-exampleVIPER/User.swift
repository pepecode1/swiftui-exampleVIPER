//
//  User.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import CoreData
/// Modelo que representa un usuario con datos obtenidos de la API
struct User: Codable {
    /// Identificador único del usuario
    let id: Int
    /// Nombre completo del usuario
    let name: String
    /// Correo electrónico del usuario
    let email: String
	/// Convierte un UserEntity a User
	/// - Parameter entity: Entidad de Core Data
	/// - Returns: Objeto User
	static func from(entity: UserEntity) -> User {
		return User(id: Int(entity.id), name: entity.name, email: entity.email)
	}
	/// Convierte un User a UserEntity
	/// - Parameters:
	///   - context: Contexto gestionado de Core Data
	/// - Returns: Entidad UserEntity
	func toEntity(in context: NSManagedObjectContext) -> UserEntity {
		let entity = UserEntity(context: context)
		entity.id = Int32(id)
		entity.name = name
		entity.email = email
		return entity
	}
}
