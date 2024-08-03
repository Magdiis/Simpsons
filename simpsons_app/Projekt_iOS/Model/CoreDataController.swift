//
//  CoreDataController.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import Foundation
import CoreData

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "Simpsons")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
