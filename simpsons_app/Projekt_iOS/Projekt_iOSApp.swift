//
//  Projekt_iOSApp.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import SwiftUI

@main
struct Projekt_iOSApp: App {
    
    @StateObject private var dataController = CoreDataController()
    var body: some Scene {
        WindowGroup {
            ContentView(episodeViewModel: EpisodeViewModel(moc: dataController.container.viewContext))
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
