//
//  DetailView.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 12.06.2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var episode: EpisodeItem
     var episodeViewModel: EpisodeViewModel
    @FetchRequest(sortDescriptors: []) var epis: FetchedResults<Episode>
    
    var body: some View {
        ScrollView{
        AsyncImage(url: URL(string:episode.thumbnailUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } else if phase.error != nil {
                Image("simpsons_placeholder")
                    .resizable()
                    .frame(width: .infinity, height: 200)
            } else {
                ProgressView()
            }
            
        }
        HStack {
            HStack{
                if(episode.isFavourite == false){
                    Image("dislike")
                        .resizable()
                        .frame(width: 31, height: 37)
                    
                } else {
                    Image("like")
                        .resizable()
                        .frame(width: 31, height: 37)
                    
                }
            }.onTapGesture {
                episodeViewModel.changeFavourite(id: episode.id)
                episodeViewModel.refresh(epis: epis)
                episodeViewModel.refreshFavouriteEpisodes()
                episodeViewModel.refreshDataToPieChart()
            }
            Spacer()
            HStack {
                switch episode.userRating{
                case 1:
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                case 2:
                    ForEach(0..<2) { _ in
                        Image("donut")
                            .resizable()
                            .frame(width: 37, height: 32)
                    }
                case 3:
                    ForEach(0..<3) { _ in
                        Image("donut")
                            .resizable()
                            .frame(width: 37, height: 32)
                    }
                case 4:
                    ForEach(0..<4) { _ in
                        Image("donut")
                            .resizable()
                            .frame(width: 37, height: 32)
                    }
                case 5:
                    ForEach(0..<5) { _ in
                        Image("donut")
                            .resizable()
                            .frame(width: 37, height: 32)
                    }
                    
                default:
                    Text("")
                }
            }
            
            
        }
        .padding([.trailing,.leading])
        ZStack {
            Rectangle()
                .foregroundColor(Color("SimpsonYellow"))
                .cornerRadius(15)
                .frame(height: 35)
            
            HStack(){
                Text("Season: \(episode.season)")
                    .font(.system(.headline,design: .rounded))
                    .foregroundColor(.black)
                    .offset(x:16)
                Spacer()
                Text("Episode: \(episode.episode)")
                    .font(.system(.headline,design: .rounded))
                    .foregroundColor(.black)
                    .offset(x:-16)
                
            }
        }
        .padding()
        
            ZStack{
                Rectangle()
                    .foregroundColor(Color("SimpsonYellow"))
                    .cornerRadius(15)
                    
                VStack(alignment:.leading ) {
                           Text("Description:")
                               .foregroundColor(.black)
                               .font(.system(.headline,design: .rounded))
                               .padding()
                           Text(episode.plot)
                               .foregroundColor(.black)
                               .font(.system(.body,design: .rounded))
                               .padding([.leading,.trailing,.bottom])
                       }
            }.padding([.leading,.trailing])
       
            
            RatingSystem(episode: $episode, episodeViewModel: episodeViewModel).onTapGesture {
                episodeViewModel.refresh(epis: epis)
                
            }
       
        
        .padding()
    }
        .navigationTitle(episode.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

