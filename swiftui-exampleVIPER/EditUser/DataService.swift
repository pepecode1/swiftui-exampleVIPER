//
//  DataService.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 30/09/25.
//
import Combine
/// Protocol for data service to save user data
protocol DataServiceProtocol {
	func saveUser(_ user: User, completion: @escaping (Result<Void, Error>) -> Void)
}
/// Mock data service for saving user data
class DataService: DataServiceProtocol {
    func saveUser(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        print("Saving user: \(user)")
        completion(.success(()))
    }
}
