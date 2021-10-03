//
//  ContentView.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 01.10.2021.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.result?.results ?? [], id: \.self) { character in
                    NavigationLink {
                        NavigationLazyView(CharacterDetailView(
                            detailViewModel: CharacterDetailViewModel(locationName: character.location.url,
                                                                      choosedCharacter: character)))
                    } label: {
                        CharacterCell(character: character)
                            .padding(.horizontal)
                    }
                }
            }
            .onAppear(perform: {
                viewModel.fetchAllCharacters()
            })
            .navigationBarTitle("Rick and Morty", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


