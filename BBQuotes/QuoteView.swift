//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Samaksh Sangwan on 11/10/25.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show : String
    @State var showCharacterInfo = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7 , height: geo.size.height * 1.2)
                
                VStack{
                    
                    Spacer(minLength: 160)
                    switch(vm.status){
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                    case .success:
                        Text("\"\(vm.quote.quote)\"")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.black.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        ZStack(alignment: .bottom){
                            AsyncImage(url: vm.character.images[0]){image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.rect(cornerRadius: 50))
                                    
                                } placeholder: {
                                ProgressView()
                            }
                                .frame(width: geo.size.width/1.1,height: geo.size.height/1.8)
                            
                            Text(vm.quote.character)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.ultraThinMaterial)
                            }
                        .frame(width: geo.size.width/1.1,height: geo.size.height/1.8)
                        .clipShape(.rect(cornerRadius: 50))
                        .onTapGesture {
                            showCharacterInfo.toggle()
                        }
                        
                    default :
                        Text("Fetching Failed")
                    }
                    
                  
                    
                    Spacer()
                    
                    Button{
                        Task {
                            await vm.getData(show: show)
                        }
                       
                    } label : {
                        Text("Get Random Quote")
                        .font(.title)
                        .padding()
                        .foregroundStyle(.white)
                        .background(show == "Breaking Bad" ? .breakingBadGreen : .betterCallSaulGrey)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(color :show=="Breaking Bad" ? .breakingBadYellow : .black, radius: 2)
                    }
                    Spacer(minLength: 185)
                    
                    
                    }
                .frame(width: geo.size.width)
                
            }
            .frame(width: geo.size.width , height: geo.size.height)
          
            
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo){
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
}
