//
//  User.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import Foundation
/// Modelo que representa un usuario con datos obtenidos de la API
struct User: Codable {
    /// Identificador único del usuario
    let id: Int
    /// Nombre completo del usuario
    let name: String
    /// Correo electrónico del usuario
    let email: String
}
