//
//  UserDetailView.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import SwiftUI
/// Vista SwiftUI que muestra los detalles de un usuario
struct UserDetailView: View {
    /// Estado para almacenar el usuario
    var user: User
    /// Cuerpo de la vista SwiftUI
    var body: some View {
        VStack(spacing: 20) {
            Text("User Details")
                .font(.title)
                .bold()
            Text("ID: \(user.id)")
                .font(.headline)
            Text("Name: \(user.name)")
                .font(.body)
            Text("Email: \(user.email)")
                .font(.body)
                .foregroundColor(.blue)
            Spacer()
        }
        .padding()
    }
}
