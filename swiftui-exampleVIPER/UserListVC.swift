//
//  UserListVC.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 25/09/25.
//
import UIKit
/// Protocolo para la vista de la lista de usuarios
protocol UserListViewProtocol: AnyObject {
    /// Muestra la lista de usuarios en la UI
    /// - Parameter users: Lista de usuarios a mostrar
    func displayUsers(_ users: [User])
    /// Muestra un mensaje de error
    /// - Parameter message: Mensaje de error a mostrar
    func showError(_ message: String)
}
/// Vista UIKit que muestra una lista de usuarios en una tabla
class UserListVC: UIViewController, UserListViewProtocol {
    /// Tabla para mostrar los usuarios
    private let tableView = UITableView()
    /// Lista de usuarios a mostrar
    private var users: [User] = []
    /// Referencia al Presenter
    var presenter: UserListPresenterProtocol?
    /// Configura la vista al cargarse
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    /// Configura la interfaz de usuario (tabla)
    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    /// Muestra los usuarios en la tabla
    /// - Parameter users: Lista de usuarios a mostrar
    func displayUsers(_ users: [User]) {
        self.users = users
        tableView.reloadData()
    }
    /// Muestra un mensaje de error en un alerta
    /// - Parameter message: Mensaje de error
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
/// Implementación del protocolo UITableViewDataSource
extension UserListVC: UITableViewDataSource {
    /// Devuelve el número de filas en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    /// Configura una celda para la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.name) - \(user.email)"
        return cell
    }
}
/// Implementación del protocolo UITableViewDelegate
extension UserListVC: UITableViewDelegate {
    /// Maneja la selección de un usuario en la tabla
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        presenter?.didSelectUser(user)
    }
}
