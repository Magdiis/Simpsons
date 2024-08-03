//
//  FavouriteScroll.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 21.06.2023.
//

import SwiftUI

struct FavouriteScroll: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel
    var forFavourite: Bool
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(alignment: .top){
                if(forFavourite == true) {
                    ForEach($episodeViewModel.episodesItems,id: \.id){ $episode in
                        if (episode.isFavourite == true) {
                            NavigationLink(destination: {
                                DetailView(episode: $episode, episodeViewModel: episodeViewModel)
                            },label: {
                                EpisodeCard(episode: $episode, forFavourite: forFavourite)
                            })
                            
                        }
                    }
                } else {
                    ForEach($episodeViewModel.episodesItems,id: \.id){ $episode in
                        if (episode.userRating > 4){
                            NavigationLink(destination: {
                                DetailView(episode: $episode, episodeViewModel: episodeViewModel)
                            },label: {
                                    EpisodeCard(episode: $episode, forFavourite: forFavourite)
                                
                            })
                        }
                    }
                }
               
            }
        }.frame(height: 210)
        //.padding(EdgeInsets(top: 0, leading: 19.5, bottom: 0, trailing: 0))
    }
}



struct EpisodeCard: View {
    @Binding var episode: EpisodeItem
    var forFavourite: Bool
    var body: some View{
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color("SimpsonYellow"))
                .cornerRadius(10)
                .frame(height: 180)
                .shadow(radius: 5)
                
            VStack(alignment:.leading) {
                AsyncImage(url: URL(string:episode.thumbnailUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 140, height: 80)
                            .cornerRadius(10)
                    } else if phase.error != nil {
                        Image("simpsons_placeholder")
                            .resizable()
                            .frame(width: 140, height: 80)
                            .cornerRadius(10)
                    } else {
                        ProgressView()
                    }
                }
                VStack {
            
                    Text(episode.name)
                    .font(.system(.headline,design: .rounded))
                    .foregroundColor(.black)
                        .frame(maxWidth: 140)
                    Spacer()
                        
                       // if(forFavourite == false){
                            HStack (spacing: 5){
                                Text("S\(episode.season)E\(episode.episode)")
                                    .foregroundColor(Color.gray)
                                    .font(.system(.subheadline,design: .rounded))
                                    .offset(x:10,y:-16)
                                    

                                Spacer()
                                Image("donut")
                                    .resizable()
                                    .frame(width: 24, height: 19)
                                    .offset(x:-10,y:-16)
                                Text("\(episode.userRating)")
                                    .foregroundColor(Color.gray)
                                    .font(.system(.subheadline,design: .rounded))
                                    .offset(x:-10,y:-16)
                            }
                      //  }
                }
                 
                    
            }
        }
        .padding([.leading,.top])
            
        }
}






