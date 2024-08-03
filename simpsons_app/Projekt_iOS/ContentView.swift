//
//  ContentView.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import SwiftUI
struct ContentView: View {
    @StateObject var episodeViewModel: EpisodeViewModel
    @FetchRequest(sortDescriptors: []) var epis: FetchedResults<Episode>
    var body: some View {
        TabView {
            MainView(episodeViewModel: episodeViewModel)
                .tabItem{
                    Label("Main",systemImage: "house")
                }
               
            EpisodesView(episodeViewModel: episodeViewModel)
                .tabItem{
                    Label("Episodes",systemImage: "list.bullet")
                }
           
        }
        .accentColor(Color("DonutPink"))
        .onAppear{
            episodeViewModel.refresh(epis: epis)
            if (episodeViewModel.episodesItems.isEmpty) {
                episodeViewModel.fetch()
            }
        }
 
    }
        
}


