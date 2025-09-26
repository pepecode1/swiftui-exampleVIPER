//
//  UserEntity+CoreDataProperties.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 26/09/25.
//
import Foundation
import CoreData
/// Propiedades de la entidad UserEntity
extension UserEntity {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
		return NSFetchRequest<UserEntity>(entityName: "UserEntity")
	}
	/// Identificador único del usuario
	@NSManaged public var id: Int32
	/// Nombre completo del usuario
	@NSManaged public var name: String
	/// Correo electrónico del usuario
	@NSManaged public var email: String
}
