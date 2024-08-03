//
//  EpisodesView.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 12.06.2023.
//

import SwiftUI

struct EpisodesView: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel
    @Environment(\.managedObjectContext) var moc
    @State private var search = ""
    var filteredEpisodes: [EpisodeItem]? {
        guard !search.isEmpty else {return nil}
        return episodeViewModel.episodesItems.filter{
            $0.name.localizedCaseInsensitiveContains(search)
        }
    }
    
    var body: some View {
        NavigationView {
            List($episodeViewModel.episodesItems,id: \.id){ $episode in
            
                if (filteredEpisodes != nil){
                    if (filteredEpisodes!.contains {$0.name == episode.name}){
                        NavigationLink {
                            DetailView(episode: $episode, episodeViewModel: episodeViewModel)
                        } label: {
                            
                            HStack{
                                AsyncImage(url: URL(string:episode.thumbnailUrl)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 70)
                                            .cornerRadius(10)
                                    } else if phase.error != nil {
                                        Image("simpsons_placeholder")
                                            .resizable()
                                            .frame(width: 120, height: 70)
                                            .cornerRadius(10)
                                    } else {
                                        ProgressView()
                                    }
                                    
                                }
                                Text(episode.name)
                            
                            }
                        }
                    }
                    
                } else {
                    NavigationLink {
                        DetailView(episode: $episode, episodeViewModel: episodeViewModel)
                    } label: {
                        HStack{
                            AsyncImage(url: URL(string:episode.thumbnailUrl)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 120, height: 70)
                                        .cornerRadius(10)
                                } else if phase.error != nil {
                                    Image("simpsons_placeholder")
                                        .resizable()
                                        .frame(width: 120, height: 70)
                                        .cornerRadius(10)
                                } else {
                                    ProgressView()
                                }
                                
                            }
                            Text(episode.name)
                        }
                    }
                }
                
                
                
            }
            //.navigationTitle("All Episodes")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    StrokeText(text: "Episodes", width: 1, color: .black)
                        .foregroundColor(Color("YellowTitle"))
                        .font(.system(.largeTitle,design: .rounded).weight(.heavy))
                }
            }
            .searchable(text: $search, prompt: "Search Episodes")
        }
            
    }
}
