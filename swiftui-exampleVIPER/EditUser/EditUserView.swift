//
//  EditUserView.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 29/09/25.
//
import SwiftUI
/// Vista para editar usuario.
struct EditUserView: View {
	/// ViewModel instance for managing user data
	@StateObject private var viewModel: EditUserViewModel
	/// Environment variable to dismiss the view
	@Environment(\.dismiss) private var dismiss
	/// Constructor
	init(user: User) {
		_viewModel = StateObject(wrappedValue: EditUserViewModel(user: user))
	}
	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("User Details")) {
					/// Text field for user name input
					TextField("Name", text: $viewModel.name)
						.autocapitalization(.words)
					/// Text field for user email input
					TextField("Email", text: $viewModel.email)
						.keyboardType(.emailAddress)
						.autocapitalization(.none)
				}
				/// Button to trigger save action
				Button(action: {
					viewModel.saveUser()
				}) {
					Text("Save")
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
			}
			.navigationTitle("Edit User")
			/// Error alert for validation or save failures
			.alert("Error", isPresented: $viewModel.showingError) {
				Button("OK", role: .cancel) { }
			} message: {
				Text(viewModel.errorMessage)
			}
			/// Success alert for successful save
			.alert("Success", isPresented: $viewModel.showingSuccess) {
				Button("OK") {
					dismiss()
				}
			} message: {
				Text("User updated successfully")
			}
		}
	}
}
