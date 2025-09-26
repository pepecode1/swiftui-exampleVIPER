//
//  CoreDataManager.swift
//  swiftui-exampleVIPER
//
//  Created by Pepe Ruiz on 26/09/25.
//
import CoreData
/// Clase singleton que gestiona el stack de Core Data
class CoreDataManager {
    /// Instancia compartida del singleton
    static let shared = CoreDataManager()
    /// Contenedor persistente para Core Data
    private let persistentContainer: NSPersistentContainer
    /// Contexto gestionado para Core Data
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    /// Inicializa el contenedor persistente
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error al cargar Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    /// Guarda los cambios en el contexto gestionado
    func saveContext() {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
                print("CoreDataManager: Context saved")
            } catch {
                let nserror = error as NSError
                print("CoreDataManager: Error al guardar contexto: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
