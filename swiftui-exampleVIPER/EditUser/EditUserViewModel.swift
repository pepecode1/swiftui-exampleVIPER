//
//  EditUserViewModel.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 30/09/25.
//
import SwiftUI
import Combine
/// ViewModel for EditUserView, handling user data and save logic
class EditUserViewModel: ObservableObject {
    /// Published user data to bind with the view
    @Published var name: String = ""
    /// Published email data to bind with the view
    @Published var email: String = ""
	/// Published id
    @Published var id: Int = 0
    /// Published error message for display
    @Published var errorMessage: String = ""
    /// Published flag to show error alert
    @Published var showingError: Bool = false
    /// Published flag to show success alert
    @Published var showingSuccess: Bool = false
    /// Private data service for saving user data
    private let dataService: DataServiceProtocol
    /// Initialize with user and data service
    init(user: User, dataService: DataServiceProtocol = DataService()) {
		self.id = user.id
		self.name = user.name
		self.email = user.email
        self.dataService = dataService
    }
    /// Validates and saves user data
    func saveUser() {
        guard !name.isEmpty, !email.isEmpty else {
            errorMessage = "Name and email cannot be empty"
            showingError = true
            return
        }
        guard email.contains("@") else {
            errorMessage = "Invalid email format"
            showingError = true
            return
        }
        let updatedUser = User(id: id, name: name, email: email)
        dataService.saveUser(updatedUser) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showingSuccess = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showingError = true
                }
            }
        }
    }
}
