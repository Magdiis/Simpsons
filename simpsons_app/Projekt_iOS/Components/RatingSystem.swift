//
//  RatingSystem.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 12.06.2023.
//

import SwiftUI

struct RatingSystem: View {
    @Binding var episode: EpisodeItem
    @ObservedObject var episodeViewModel: EpisodeViewModel
    @FetchRequest(sortDescriptors: []) var epis: FetchedResults<Episode>
    
    var body: some View {
        
        HStack(spacing: 5) {
            Button(action: {
                episodeViewModel.changeRating(id: episode.id, newRating: 1)
                episodeViewModel.refresh(epis: epis)
                episodeViewModel.refreshBestEpisodes()
            
            }, label: {
                if (episode.userRating < 1){
                    Image("donutBlack")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                } else {
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                }
            })
            
            Button(action: {
                episodeViewModel.changeRating(id: episode.id, newRating: 2)
                episodeViewModel.refresh(epis: epis)
                episodeViewModel.refreshBestEpisodes()
                
            }, label: {
                if (episode.userRating < 2){
                    Image("donutBlack")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                } else {
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                }
            })
            Button(action: {
                episodeViewModel.changeRating(id: episode.id, newRating: 3)
                episodeViewModel.refresh(epis: epis)
                episodeViewModel.refreshBestEpisodes()
             
               
            }, label: {
                if (episode.userRating < 3){
                    Image("donutBlack")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                } else {
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                }
            })
            Button(action: {
                episodeViewModel.changeRating(id: episode.id, newRating: 4)
                episodeViewModel.refresh(epis: epis)
                episodeViewModel.refreshBestEpisodes()
               
             
            }, label: {
                if (episode.userRating < 4){
                    Image("donutBlack")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                } else {
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                }
            })
            Button(action: {
                episodeViewModel.changeRating(id: episode.id, newRating: 5)
                episodeViewModel.refresh(epis: epis)
                episodeViewModel.refreshBestEpisodes()
               
                
            }, label: {
                if (episode.userRating < 5){
                    Image("donutBlack")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                } else {
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                        .shadow(radius: 5)
                }
            })
        }.padding()
        
    }
  
    
}





